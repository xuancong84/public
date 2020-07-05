-- ffi setup
local ffi = require("ffi")
local C = ffi.C
ffi.cdef [[
	typedef int32_t BlacklistID;
	typedef uint64_t BuildTaskID;
	typedef uint64_t MissionID;
	typedef uint64_t NPCSeed;
	typedef uint64_t TradeID;
	typedef uint64_t UniverseID;
	typedef struct {
		const char* macro;
		const char* ware;
		uint32_t amount;
		uint32_t capacity;
	} AmmoData;
	typedef struct {
		const char* id;
		const char* text;
	} BoardingBehaviour;
	typedef struct {
		const char* id;
		const char* text;
	} BoardingPhase;
	typedef struct {
		uint32_t approach;
		uint32_t insertion;
	} BoardingRiskThresholds;
	typedef struct {
		BuildTaskID id;
		UniverseID buildingcontainer;
		UniverseID component;
		const char* macro;
		const char* factionid;
		UniverseID buildercomponent;
		int64_t price;
		bool ismissingresources;
		uint32_t queueposition;
	} BuildTaskInfo;
	typedef struct {
		const char* newroleid;
		NPCSeed seed;
		uint32_t amount;
	} CrewTransferContainer;
	typedef struct {
		const char* id;
		const char* name;
	} ControlPostInfo;
	typedef struct {
		const char* id;
		const char* name;
		const char* description;
	} ResponseInfo;
	typedef struct {
		const char* id;
		const char* name;
		const char* description;
		uint32_t numresponses;
		const char* defaultresponse;
		bool ask;
	} SignalInfo;
	typedef struct {
		const char* name;
		const char* transport;
		uint32_t spaceused;
		uint32_t capacity;
	} StorageInfo;
	typedef struct {
		int x;
		int y;
	} Coord2D;
	typedef struct {
		float x;
		float y;
		float z;
	} Coord3D;
	typedef struct {
		float dps;
		uint32_t quadranttextid;
	} DPSData;
	typedef struct {
		const char* id;
		const char* name;
		bool possible;
	} DroneModeInfo;
	typedef struct {
		const char* factionID;
		const char* factionName;
		const char* factionIcon;
	} FactionDetails;
	typedef struct {
		const char* icon;
		const char* caption;
	} MissionBriefingIconInfo;
	typedef struct {
		const char* missionName;
		const char* missionDescription;
		int difficulty;
		int upkeepalertlevel;
		const char* threadType;
		const char* mainType;
		const char* subType;
		const char* subTypeName;
		const char* faction;
		int64_t reward;
		const char* rewardText;
		size_t numBriefingObjectives;
		int activeBriefingStep;
		const char* opposingFaction;
		const char* license;
		float timeLeft;
		double duration;
		bool abortable;
		bool hasObjective;
		UniverseID associatedComponent;
		UniverseID threadMissionID;
	} MissionDetails;
	typedef struct {
		const char* id;
		const char* name;
	} MissionGroupDetails;
	typedef struct {
		const char* text;
		int step;
		bool failed;
	} MissionObjectiveStep2;
	typedef struct {
		NPCSeed seed;
		const char* roleid;
		int32_t tierid;
		const char* name;
		int32_t combinedskill;
	} NPCInfo;
	typedef struct {
		const char* id;
		const char* name;
		const char* icon;
		const char* description;
		const char* category;
		const char* categoryname;
		bool infinite;
		uint32_t requiredSkill;
	} OrderDefinition;
	typedef struct {
		size_t queueidx;
		const char* state;
		const char* statename;
		const char* orderdef;
		size_t actualparams;
		bool enabled;
		bool isinfinite;
		bool issyncpointreached;
		bool istemporder;
	} Order;
	typedef struct {
		size_t queueidx;
		const char* state;
		const char* statename;
		const char* orderdef;
		size_t actualparams;
		bool enabled;
		bool isinfinite;
		bool issyncpointreached;
		bool istemporder;
		bool isoverride;
	} Order2;
	typedef struct {
		const char* id;
		const char* name;
		const char* desc;
		uint32_t amount;
		uint32_t numtiers;
		bool canhire;
	} PeopleInfo;
	typedef struct {
		const char* id;
		const char* name;
		const char* shortname;
		const char* description;
		const char* icon;
	} RaceInfo;
	typedef struct {
		const char* name;
		int32_t skilllevel;
		uint32_t amount;
	} RoleTierData;
	typedef struct {
		UniverseID context;
		const char* group;
		UniverseID component;
	} ShieldGroup;
	typedef struct {
		uint32_t textid;
		uint32_t descriptionid;
		uint32_t value;
		uint32_t relevance;
	} Skill2;
	typedef struct {
		UniverseID softtargetID;
		const char* softtargetConnectionName;
	} SofttargetDetails;
	typedef struct {
		const char* max;
		const char* current;
	} SoftwareSlot;
	typedef struct {
		uint32_t id;
		bool reached;
	} SyncPointInfo;
	typedef struct {
		const char* shape;
		const char* name;
		uint32_t requiredSkill;
		float radius;
		bool rollMembers;
		bool rollFormation;
		size_t maxShipsPerLine;
	} UIFormationInfo;
	typedef struct {
		const char* file;
		const char* icon;
		bool ispersonal;
	} UILogo;
	typedef struct {
		const char* icon;
		Color color;
		uint32_t volume_s;
		uint32_t volume_m;
		uint32_t volume_l;
	} UIMapTradeVolumeParameter;
	typedef struct {
		const char* id;
		const char* name;
	} UIModuleSet;
	typedef struct {
		const float x;
		const float y;
		const float z;
		const float yaw;
		const float pitch;
		const float roll;
	} UIPosRot;
	typedef struct {
		const char* wareid;
		uint32_t amount;
	} UIWareAmount;
	typedef struct {
		bool primary;
		uint32_t idx;
	} UIWeaponGroup;
	typedef struct {
		UniverseID contextid;
		const char* path;
		const char* group;
	} UpgradeGroup2;
	typedef struct {
		UniverseID currentcomponent;
		const char* currentmacro;
		const char* slotsize;
		uint32_t count;
		uint32_t operational;
		uint32_t total;
	} UpgradeGroupInfo;
	typedef struct {
		UniverseID reserverid;
		const char* ware;
		uint32_t amount;
		bool isbuyreservation;
		double eta;
	} WareReservationInfo;
	typedef struct {
		const char* id;
		const char* name;
		bool active;
	} WeaponSystemInfo;
	typedef struct {
		uint32_t current;
		uint32_t capacity;
		uint32_t optimal;
		uint32_t available;
		uint32_t maxavailable;
		double timeuntilnextupdate;
	} WorkForceInfo;
	typedef struct {
		const char* wareid;
		int32_t amount;
	} YieldInfo;

	typedef struct {
		UIPosRot offset;
		float cameradistance;
	} HoloMapState;
	typedef struct {
		size_t idx;
		const char* macroid;
		UniverseID componentid;
		UIPosRot offset;
		const char* connectionid;
		size_t predecessoridx;
		const char* predecessorconnectionid;
		bool isfixed;
	} UIConstructionPlanEntry;
	bool AbortBoardingOperation(UniverseID defensibletargetid, const char* boarderfactionid);
	void AbortMission(MissionID missionid);
	bool AddAttackerToBoardingOperation(UniverseID defensibletargetid, UniverseID defensibleboarderid, const char* boarderfactionid, const char* actionid, uint32_t* marinetieramounts, int32_t* marinetierskilllevels, uint32_t nummarinetiers);
	void AddCrewExchangeOrder(UniverseID containerid, UniverseID partnercontainerid, NPCSeed* npcs, uint32_t numnpcs, NPCSeed* partnernpcs, uint32_t numpartnernpcs, bool tradecomputer);
	UniverseID AddHoloMap(const char* texturename, float x0, float x1, float y0, float y1, float aspectx, float aspecty);
	void AddPlayerMoney(int64_t money);
	void AddResearch(const char* wareid);
	void AddSimilarMapComponentsToSelection(UniverseID holomapid, UniverseID componentid);
	bool AdjustOrder(UniverseID controllableid, size_t idx, size_t newidx, bool enabled, bool forcestates, bool checkonly);
	bool GetAskToSignalForControllable(const char* signalid, UniverseID controllableid);
	bool GetAskToSignalForFaction(const char* signalid, const char* factionid);
	uint32_t GetAttackersOfBoardingOperation(UniverseID* result, uint32_t resultlen, UniverseID defensibletargetid, const char* boarderfactionid);
	bool CanContainerMineTransport(UniverseID containerid, const char* transportname);
	bool CanContainerTransport(UniverseID containerid, const char* transportname);
	bool CanControllableHaveControlEntity(UniverseID controllableid, const char* postid);
	bool CanPlayerCommTarget(UniverseID componentid);
	void ChangeMapBuildPlot(UniverseID holomapid, float x, float y, float z);
	void CheatDockingTraffic(void);
	void ClearSelectedMapComponents(UniverseID holomapid);
	void ClearMapBuildPlot(UniverseID holomapid);
	void ClearMapTradeFilterByMinTotalVolume(UniverseID holomapid);
	void ClearMapTradeFilterByPlayerOffer(UniverseID holomapid, bool buysellswitch);
	void ClearMapTradeFilterByWare(UniverseID holomapid);
	bool CreateBoardingOperation(UniverseID defensibletargetid, const char* boarderfactionid, uint32_t approachthreshold, uint32_t insertionthreshold);
	UniverseID CreateNPCFromPerson(NPCSeed person, UniverseID controllableid);
	uint32_t CreateOrder(UniverseID controllableid, const char* orderid, bool default);
	bool DropCargo(UniverseID containerid, const char* wareid, uint32_t amount);
	void EnableAllCheats(void);
	bool EnableOrder(UniverseID controllableid, size_t idx);
	bool EnablePlannedDefaultOrder(UniverseID controllableid, bool checkonly);
	void EndGuidance(void);
	bool ExtendBuildPlot(UniverseID stationid, Coord3D poschange, Coord3D negchange, bool allowreduction);
	bool FilterComponentByText(UniverseID componentid, uint32_t numtexts, const char** textarray, bool includecontainedobjects);
	uint64_t GetActiveMissionID();
	uint32_t GetAllBoardingBehaviours(BoardingBehaviour* result, uint32_t resultlen);
	uint32_t GetAllBoardingPhases(BoardingPhase* result, uint32_t resultlen);
	uint32_t GetAllControlPosts(ControlPostInfo* result, uint32_t resultlen);
	uint32_t GetAllCountermeasures(AmmoData* result, uint32_t resultlen, UniverseID defensibleid);
	uint32_t GetAllInventoryBombs(AmmoData* result, uint32_t resultlen, UniverseID entityid);
	uint32_t GetAllLaserTowers(AmmoData* result, uint32_t resultlen, UniverseID defensibleid);
	uint32_t GetAllMines(AmmoData* result, uint32_t resultlen, UniverseID defensibleid);
	uint32_t GetAllMissiles(AmmoData* result, uint32_t resultlen, UniverseID defensibleid);
	uint32_t GetAllNavBeacons(AmmoData* result, uint32_t resultlen, UniverseID defensibleid);
	uint32_t GetAllRaces(RaceInfo* result, uint32_t resultlen);
	uint32_t GetAllResourceProbes(AmmoData* result, uint32_t resultlen, UniverseID defensibleid);
	uint32_t GetAllSatellites(AmmoData* result, uint32_t resultlen, UniverseID defensibleid);
	uint32_t GetAllModuleSets(UIModuleSet* result, uint32_t resultlen);
	uint32_t GetAllowedWeaponSystems(WeaponSystemInfo* result, uint32_t resultlen, UniverseID defensibleid, size_t orderidx, bool usedefault);
	uint32_t GetAllResponsesToSignal(ResponseInfo* result, uint32_t resultlen, const char* signalid);
	uint32_t GetAllSignals(SignalInfo* result, uint32_t resultlen);
	const char* GetBoardingActionOfAttacker(UniverseID defensibletargetid, UniverseID defensibleboarderid, const char* boarderfactionid);
	uint32_t GetBoardingCasualtiesOfTier(int32_t marinetierskilllevel, UniverseID defensibletargetid, const char* boarderfactionid);
	bool GetBoardingMarineTierAmountsFromAttacker(uint32_t* resultmarinetieramounts, int32_t* inputmarinetierskilllevels, uint32_t inputnummarinetiers, UniverseID defensibletargetid, UniverseID defensibleboarderid, const char* boarderfactionid);
	BoardingRiskThresholds GetBoardingRiskThresholds(UniverseID defensibletargetid, const char* boarderfactionid);
	uint32_t GetBoardingStrengthFromOperation(UniverseID defensibletargetid, const char* boarderfactionid);
	uint32_t GetBoardingStrengthOfControllableTierAmounts(UniverseID controllableid, uint32_t* marinetieramounts, int32_t* marinetierskilllevels, uint32_t nummarinetiers);
	int64_t GetBuilderHiringFee(void);
	bool GetBuildMapStationLocation(UniverseID holomapid, UIPosRot* location);
	double GetBuildProcessorEstimatedTimeLeft(UniverseID buildprocessorid);
	Coord3D GetBuildPlotCenterOffset(UniverseID stationid);
	int64_t GetBuildPlotPayment(UniverseID stationid, bool* positionchanged);
	int64_t GetBuildPlotPrice(UniverseID sectorid, UIPosRot location, float x, float y, float z, const char* factionid);
	Coord3D GetBuildPlotSize(UniverseID stationid);
	double GetBuildTaskDuration(UniverseID containerid, BuildTaskID id);
	uint32_t GetBuildTasks(BuildTaskInfo* result, uint32_t resultlen, UniverseID containerid, UniverseID buildmoduleid, bool isinprogress, bool includeupgrade);
	uint32_t GetCargoTransportTypes(StorageInfo* result, uint32_t resultlen, UniverseID containerid, bool merge, bool aftertradeorders);
	Coord2D GetCenteredMousePos(void);
	UniverseID GetCommonContext(UniverseID componentid, UniverseID othercomponentid, bool includeself, bool includeother, UniverseID limitid, bool includelimit);
	const char* GetComponentClass(UniverseID componentid);
	const char* GetComponentName(UniverseID componentid);
	int GetConfigSetting(const char*const setting);
	uint32_t GetContainerWareReservations(WareReservationInfo* result, uint32_t resultlen, UniverseID containerid);
	UniverseID GetContextByClass(UniverseID componentid, const char* classname, bool includeself);
	BlacklistID GetControllableBlacklistID(UniverseID controllableid, const char* listtype, const char* defaultgroup);
	const char* GetCurrentAmmoOfWeapon(UniverseID weaponid);
	const char* GetCurrentBoardingPhase(UniverseID defensibletargetid, const char* boarderfactionid);
	float GetCurrentBuildProgress(UniverseID containerid);
	const char* GetCurrentDroneMode(UniverseID defensibleid, const char* dronetype);
	uint32_t GetCurrentMissionOffers(uint64_t* result, uint32_t resultlen, bool showninbbs);
	UILogo GetCurrentPlayerLogo(void);
	bool GetDefaultOrder(Order* result, UniverseID controllableid);
	const char* GetDefaultResponseToSignalForControllable(const char* signalid, UniverseID controllableid);
	const char* GetDefaultResponseToSignalForFaction(const char* signalid, const char* factionid);
	uint32_t GetDefensibleActiveWeaponGroup(UniverseID defensibleid, bool primary);
	uint32_t GetDefensibleDPS(DPSData* result, UniverseID defensibleid, bool primary, bool secondary, bool lasers, bool missiles, bool turrets, bool includeheat, bool includeinactive);
	uint32_t GetDefensibleDeployableCapacity(UniverseID defensibleid);
	float GetDefensibleLoadoutLevel(UniverseID defensibleid);
	uint32_t GetDockedShips(UniverseID* result, uint32_t resultlen, UniverseID dockingbayorcontainerid, const char* factionid);
	uint32_t GetDroneModes(DroneModeInfo* result, uint32_t resultlen, UniverseID defensibleid, const char* dronetype);
	int32_t GetEntityCombinedSkill(UniverseID entityid, const char* role, const char* postid);
	FactionDetails GetFactionDetails(const char* factionid);
	const char* GetFleetName(UniverseID controllableid);
	uint32_t GetFormationShapes(UIFormationInfo* result, uint32_t resultlen);
	uint32_t GetFreeCountermeasureStorageAfterTradeOrders(UniverseID defensibleid);
	uint32_t GetFreeDeployableStorageAfterTradeOrders(UniverseID defensibleid);
	uint32_t GetFreeMissileStorageAfterTradeOrders(UniverseID defensibleid);
	uint32_t GetFreePeopleCapacity(UniverseID controllableid);
	uint32_t GetIllegalToFactions(const char** result, uint32_t resultlen, const char* wareid);
	UniverseID GetInstantiatedPerson(NPCSeed person, UniverseID controllableid);
	const char* GetLocalizedText(const uint32_t pageid, uint32_t textid, const char*const defaultvalue);
	uint32_t GetMapComponentMissions(MissionID* result, uint32_t resultlen, UniverseID holomapid, UniverseID componentid);
	UniverseID GetMapPositionOnEcliptic2(UniverseID holomapid, UIPosRot* position, bool adaptiveecliptic, UniverseID eclipticsectorid, UIPosRot eclipticoffset);
	uint32_t GetMapRenderedComponents(UniverseID* result, uint32_t resultlen, UniverseID holomapid);
	uint32_t GetMapSelectedComponents(UniverseID* result, uint32_t resultlen, UniverseID holomapid);
	void GetMapState(UniverseID holomapid, HoloMapState* state);
	UIMapTradeVolumeParameter GetMapTradeVolumeParameter(void);
	uint32_t GetMaxProductionStorage(UIWareAmount* result, uint32_t resultlen, UniverseID containerid);
	uint32_t GetMineablesAtSectorPos(YieldInfo* result, uint32_t resultlen, UniverseID sectorid, Coord3D position);
	Coord3D GetMinimumBuildPlotCenterOffset(UniverseID stationid);
	Coord3D GetMinimumBuildPlotSize(UniverseID stationid);
	MissionBriefingIconInfo GetMissionBriefingIcon(MissionID missionid);
	MissionGroupDetails GetMissionGroupDetails(MissionID missionid);
	uint32_t GetMissionThreadSubMissions(MissionID* result, uint32_t resultlen, MissionID missionid);
	MissionDetails GetMissionIDDetails(uint64_t missionid);
	MissionObjectiveStep2 GetMissionObjectiveStep2(uint64_t missionid, size_t objectiveIndex);
	uint32_t GetNumAllBoardingBehaviours(void);
	uint32_t GetNumAllBoardingPhases(void);
	uint32_t GetNumAllControlPosts(void);
	uint32_t GetNumAllCountermeasures(UniverseID defensibleid);
	uint32_t GetNumAllInventoryBombs(UniverseID entityid);
	uint32_t GetNumAllLaserTowers(UniverseID defensibleid);
	uint32_t GetNumAllMines(UniverseID defensibleid);
	uint32_t GetNumAllMissiles(UniverseID defensibleid);
	uint32_t GetNumAllNavBeacons(UniverseID defensibleid);
	uint32_t GetNumAllResourceProbes(UniverseID defensibleid);
	uint32_t GetNumAllSatellites(UniverseID defensibleid);
	uint32_t GetNumAllModuleSets();
	uint32_t GetNumAllowedWeaponSystems(void);
	uint32_t GetNumAllRaces(void);
	uint32_t GetNumAllResponsesToSignal(const char* signalid);
	uint32_t GetNumAllRoles(void);
	uint32_t GetNumAllSignals(void);
	uint32_t GetNumAttackersOfBoardingOperation(UniverseID defensibletargetid, const char* boarderfactionid);
	uint32_t GetNumBoardingMarinesFromOperation(UniverseID defensibletargetid, const char* boarderfactionid);
	uint32_t GetNumBuildTasks(UniverseID containerid, UniverseID buildmoduleid, bool isinprogress, bool includeupgrade);
	uint32_t GetNumCargoTransportTypes(UniverseID containerid, bool merge);
	uint32_t GetNumContainerWareReservations(UniverseID containerid);
	uint32_t GetNumCurrentMissionOffers(bool showninbbs);
	uint32_t GetNumDockedShips(UniverseID dockingbayorcontainerid, const char* factionid);
	uint32_t GetNumDroneModes(UniverseID defensibleid, const char* dronetype);
	uint32_t GetNumFormationShapes(void);
	uint32_t GetNumIllegalToFactions(const char* wareid);
	uint32_t GetNumMapComponentMissions(UniverseID holomapid, UniverseID componentid);
	uint32_t GetNumMapRenderedComponents(UniverseID holomapid);
	uint32_t GetNumMapSelectedComponents(UniverseID holomapid);
	uint32_t GetNumMaxProductionStorage(UniverseID containerid);
	uint32_t GetNumMineablesAtSectorPos(UniverseID sectorid, Coord3D position);
	uint32_t GetNumMissionThreadSubMissions(MissionID missionid);
	uint32_t GetNumObjectsWithSyncPoint(uint32_t syncid, bool onlyreached);
	uint32_t GetNumOrderDefinitions(void);
	uint32_t GetNumOrders(UniverseID controllableid);
	uint32_t GetNumPeopleAfterOrders(UniverseID controllableid, int32_t numorders);
	uint32_t GetNumPersonSuitableControlPosts(UniverseID controllableid, UniverseID personcontrollableid, NPCSeed person, bool free);
	size_t GetNumPlannedStationModules(UniverseID defensibleid, bool includeall);
	uint32_t GetNumPlayerShipBuildTasks(bool isinprogress, bool includeupgrade);
	uint32_t GetNumSkills(void);
	uint32_t GetNumShieldGroups(UniverseID defensibleid);
	uint32_t GetNumSoftwareSlots(UniverseID controllableid, const char* macroname);
	uint32_t GetNumStationModules(UniverseID stationid, bool includeconstructions, bool includewrecks);
	uint32_t GetNumStoredUnits(UniverseID defensibleid, const char* cat, bool virtualammo);
	uint32_t GetNumSuitableControlPosts(UniverseID controllableid, UniverseID entityid, bool free);
	uint32_t GetNumTiersOfRole(const char* role);
	size_t GetNumTradeComputerOrders(UniverseID controllableid);
	uint32_t GetNumUpgradeGroups(UniverseID destructibleid, const char* macroname);
	size_t GetNumUpgradeSlots(UniverseID destructibleid, const char* macroname, const char* upgradetypename);
	size_t GetNumVirtualUpgradeSlots(UniverseID objectid, const char* macroname, const char* upgradetypename);
	uint32_t GetNumWareBlueprintOwners(const char* wareid);
	uint32_t GetNumWares(const char* tags, bool research, const char* licenceownerid, const char* exclusiontags);
	uint32_t GetNumWeaponGroupsByWeapon(UniverseID defensibleid, UniverseID weaponid);
	const char* GetObjectIDCode(UniverseID objectid);
	UIPosRot GetObjectPositionInSector(UniverseID objectid);
	bool GetOrderDefinition(OrderDefinition* result, const char* orderdef);
	uint32_t GetOrderDefinitions(OrderDefinition* result, uint32_t resultlen);
	uint32_t GetOrders(Order* result, uint32_t resultlen, UniverseID controllableid);
	uint32_t GetOrders2(Order2* result, uint32_t resultlen, UniverseID controllableid);
	FactionDetails GetOwnerDetails(UniverseID componentid);
	Coord3D GetPaidBuildPlotCenterOffset(UniverseID stationid);
	Coord3D GetPaidBuildPlotSize(UniverseID stationid);
	UniverseID GetParentComponent(UniverseID componentid);
	uint32_t GetPeople(PeopleInfo* result, uint32_t resultlen, UniverseID controllableid);
	uint32_t GetPeopleAfterOrders(NPCInfo* result, uint32_t resultlen, UniverseID controllableid, int32_t numorders);
	uint32_t GetPeopleCapacity(UniverseID controllableid, const char* macroname, bool includecrew);
	int32_t GetPersonCombinedSkill(UniverseID controllableid, NPCSeed person, const char* role, const char* postid);
	const char* GetPersonName(NPCSeed person, UniverseID controllableid);
	const char* GetPersonRole(NPCSeed person, UniverseID controllableid);
	uint32_t GetPersonSkillsForAssignment(Skill2* result, NPCSeed person, UniverseID controllableid, const char* role, const char* postid);
	uint32_t GetPersonSuitableControlPosts(ControlPostInfo* result, uint32_t resultlen, UniverseID controllableid, UniverseID personcontrollableid, NPCSeed person, bool free);
	int32_t GetPersonTier(NPCSeed npc, const char* role, UniverseID controllableid);
	UniverseID GetPickedMapComponent(UniverseID holomapid);
	MissionID GetPickedMapMission(UniverseID holomapid);
	UniverseID GetPickedMapMissionOffer(UniverseID holomapid);
	UniverseID GetPickedMapOrder(UniverseID holomapid, Order* result, bool* intermediate);
	TradeID GetPickedMapTradeOffer(UniverseID holomapid);
	bool GetPlannedDefaultOrder(Order* result, UniverseID controllableid);
	size_t GetPlannedStationModules(UIConstructionPlanEntry* result, uint32_t resultlen, UniverseID defensibleid, bool includeall);
	UniverseID GetPlayerComputerID(void);
	UniverseID GetPlayerContainerID(void);
	UniverseID GetPlayerControlledShipID(void);
	float GetPlayerGlobalLoadoutLevel(void);
	UniverseID GetPlayerID(void);
	UniverseID GetPlayerObjectID(void);
	UniverseID GetPlayerOccupiedShipID(void);
	uint32_t GetPlayerShipBuildTasks(BuildTaskInfo* result, uint32_t resultlen, bool isinprogress, bool includeupgrade);
	UIPosRot GetPlayerTargetOffset(void);
	const char* GetRealComponentClass(UniverseID componentid);
	uint32_t GetRoleTierNPCs(NPCSeed* result, uint32_t resultlen, UniverseID controllableid, const char* role, int32_t skilllevel);
	uint32_t GetRoleTiers(RoleTierData* result, uint32_t resultlen, UniverseID controllableid, const char* role);
	UniverseID GetSectorControlStation(UniverseID sectorid);
	uint32_t GetShieldGroups(ShieldGroup* result, uint32_t resultlen, UniverseID defensibleid);
	int32_t GetShipCombinedSkill(UniverseID shipid);
	SofttargetDetails GetSofttarget(void);
	uint32_t GetSoftwareSlots(SoftwareSlot* result, uint32_t resultlen, UniverseID controllableid, const char* macroname);
	uint32_t GetStationModules(UniverseID* result, uint32_t resultlen, UniverseID stationid, bool includeconstructions, bool includewrecks);
	const char* GetSubordinateGroupAssignment(UniverseID controllableid, int group);
	uint32_t GetSuitableControlPosts(ControlPostInfo* result, uint32_t resultlen, UniverseID controllableid, UniverseID entityid, bool free);
	bool GetSyncPointInfo(UniverseID controllableid, size_t orderidx, SyncPointInfo* result);
	float GetTextHeight(const char*const text, const char*const fontname, const float fontsize, const float wordwrapwidth);
	uint32_t GetTiersOfRole(RoleTierData* result, uint32_t resultlen, const char* role);
	UniverseID GetTopLevelContainer(UniverseID componentid);
	const char* GetTurretGroupMode2(UniverseID defensibleid, UniverseID contextid, const char* path, const char* group);
	UpgradeGroupInfo GetUpgradeGroupInfo2(UniverseID destructibleid, const char* macroname, UniverseID contextid, const char* path, const char* group, const char* upgradetypename);
	uint32_t GetUpgradeGroups2(UpgradeGroup2* result, uint32_t resultlen, UniverseID destructibleid, const char* macroname);
	UniverseID GetUpgradeSlotCurrentComponent(UniverseID destructibleid, const char* upgradetypename, size_t slot);
	UpgradeGroup GetUpgradeSlotGroup(UniverseID destructibleid, const char* macroname, const char* upgradetypename, size_t slot);
	const char* GetVirtualUpgradeSlotCurrentMacro(UniverseID defensibleid, const char* upgradetypename, size_t slot);
	uint32_t GetWareBlueprintOwners(const char** result, uint32_t resultlen, const char* wareid);
	uint32_t GetWares(const char** result, uint32_t resultlen, const char* tags, bool research, const char* licenceownerid, const char* exclusiontags);
	uint32_t GetWeaponGroupsByWeapon(UIWeaponGroup* result, uint32_t resultlen, UniverseID defensibleid, UniverseID weaponid);
	const char* GetWeaponMode(UniverseID weaponid);
	WorkForceInfo GetWorkForceInfo(UniverseID containerid, const char* raceid);
	UniverseID GetZoneAt(UniverseID sectorid, UIPosRot* uioffset);
	bool HasControllableOwnBlacklist(UniverseID controllableid, const char* listtype);
	bool HasControllableOwnResponse(UniverseID controllableid, const char* signalid);
	bool IsAmmoMacroCompatible(const char* weaponmacroname, const char* ammomacroname);
	bool IsBuilderBusy(UniverseID shipid);
	bool IsComponentClass(UniverseID componentid, const char* classname);
	bool IsComponentOperational(UniverseID componentid);
	bool IsComponentWrecked(UniverseID componentid);
	bool IsContainerFactionTradeRescricted(UniverseID containerid, const char* wareid);
	bool IsContestedSector(UniverseID sectorid);
	bool IsControlPressed(void);
	bool IsCurrentOrderCritical(UniverseID controllableid);
	bool IsDefensibleBeingBoardedBy(UniverseID defensibleid, const char* factionid);
	bool IsDroneTypeArmed(UniverseID defensibleid, const char* dronetype);
	bool IsDroneTypeBlocked(UniverseID defensibleid, const char* dronetype);
	bool IsExternalTargetMode();
	bool IsExternalViewActive();
	bool IsFactionHQ(UniverseID stationid);
	bool IsHQ(UniverseID stationid);
	bool IsIconValid(const char* iconid);
	bool IsInfoUnlockedForPlayer(UniverseID componentid, const char* infostring);
	bool IsMasterVersion(void);
	bool IsObjectKnown(const UniverseID componentid);
	bool IsOrderSelectableFor(const char* orderdefid, UniverseID controllableid);
	bool IsPerson(NPCSeed person, UniverseID controllableid);
	bool IsPersonTransferScheduled(UniverseID controllableid, NPCSeed person);
	bool IsPlayerCameraTargetViewPossible(UniverseID targetid, bool force);
	bool IsRealComponentClass(UniverseID componentid, const char* classname);
	bool IsShiftPressed(void);
	bool IsShipAtExternalDock(UniverseID shipid);
	bool IsTurretGroupArmed(UniverseID defensibleid, UniverseID contextid, const char* path, const char* group);
	bool IsUnit(UniverseID controllableid);
	bool IsWeaponArmed(UniverseID weaponid);
	void LaunchLaserTower(UniverseID defensibleid, const char* lasertowermacroname);
	void LaunchMine(UniverseID defensibleid, const char* minemacroname);
	void LaunchNavBeacon(UniverseID defensibleid, const char* navbeaconmacroname);
	void LaunchResourceProbe(UniverseID defensibleid, const char* resourceprobemacroname);
	void LaunchSatellite(UniverseID defensibleid, const char* satellitemacroname);
	void PayBuildPlotSize(UniverseID stationid, Coord3D plotsize, Coord3D plotcenter);
	void ReassignPeople(UniverseID controllableid, CrewTransferContainer* reassignedcrew, uint32_t amount);
	void ReleaseConstructionMapState(void);
	void ReleasePersonFromCrewTransfer(UniverseID controllableid, NPCSeed person);
	void ReleaseOrderSyncPoint(uint32_t syncid);
	bool RemoveAllOrders(UniverseID controllableid);
	bool RemoveAttackerFromBoardingOperation(UniverseID defensibleboarderid);
	bool RemoveCommander2(UniverseID controllableid);
	bool RemoveBuildPlot(UniverseID stationid);
	void RemoveHoloMap(void);
	bool RemoveOrder(UniverseID controllableid, size_t idx, bool playercancelled, bool checkonly);
	void RemoveOrderSyncPointID(UniverseID controllableid, size_t orderidx);
	void RemovePerson(UniverseID controllableid, NPCSeed person);
	void RemovePlannedDefaultOrder(UniverseID controllableid);
	UniverseID ReserveBuildPlot(UniverseID sectorid, const char* factionid, const char* set, UIPosRot location, float x, float y, float z);
	bool ResetResponseToSignalForControllable(const char* signalid, UniverseID controllableid);
	void RevealEncyclopedia(void);
	void RevealMap(void);
	void RevealStations(void);
	bool SetActiveMission(MissionID missionid);
	void SelectSimilarMapComponents(UniverseID holomapid, UniverseID componentid);
	void SellPlayerShip(UniverseID shipid, UniverseID shipyardid);
	void SetAllMissileTurretModes(UniverseID defensibleid, const char* mode);
	void SetAllMissileTurretsArmed(UniverseID defensibleid, bool arm);
	void SetAllNonMissileTurretModes(UniverseID defensibleid, const char* mode);
	void SetAllNonMissileTurretsArmed(UniverseID defensibleid, bool arm);
	void SetAllowedWeaponSystems(UniverseID defensibleid, size_t orderidx, bool usedefault, WeaponSystemInfo* uiweaponsysteminfo, uint32_t numuiweaponsysteminfo);
	void SetAllTurretModes(UniverseID defensibleid, const char* mode);
	void SetAllTurretsArmed(UniverseID defensibleid, bool arm);
	bool SetAmmoOfWeapon(UniverseID weaponid, const char* newammomacro);
	void SetCheckBoxChecked2(const int checkboxid, bool checked, bool update);
	bool SetCommander(UniverseID controllableid, UniverseID commanderid, const char* assignment);
	void SetConfigSetting(const char*const setting, const bool value);
	void SetControllableBlacklist(UniverseID controllableid, BlacklistID id, const char* listtype, bool value);
	bool SetDefaultResponseToSignalForControllable(const char* newresponse, bool ask, const char* signalid, UniverseID controllableid);
	bool SetDefaultResponseToSignalForFaction(const char* newresponse, bool ask, const char* signalid, const char* factionid);
	void SetDefensibleActiveWeaponGroup(UniverseID defensibleid, bool primary, uint32_t groupidx);
	void SetDefensibleLoadoutLevel(UniverseID defensibleid, float value);
	void SetDroneMode(UniverseID defensibleid, const char* dronetype, const char* mode);
	void SetDroneTypeArmed(UniverseID defensibleid, const char* dronetype, bool arm);
	void SetFleetName(UniverseID controllableid, const char* fleetname);
	void SetFocusMapComponent(UniverseID holomapid, UniverseID componentid, bool resetplayerpan);
	UIFormationInfo SetFormationShape(UniverseID objectid, const char* formationshape);
	bool SetEntityToPost(UniverseID controllableid, UniverseID entityid, const char* postid);
	void SetGuidance(UniverseID componentid, UIPosRot offset);
	void SetMapFactionRelationColorOption(UniverseID holomapid, bool value);
	void SetMapFilterString(UniverseID holomapid, uint32_t numtexts, const char** textarray);
	void SetMapPanOffset(UniverseID holomapid, UniverseID offsetcomponentid);
	void SetMapPicking(UniverseID holomapid, bool enable);
	void SetMapRelativeMousePosition(UniverseID holomapid, bool valid, float x, float y);
	void SetMapRenderAllAllyOrderQueues(UniverseID holomapid, bool value);
	void SetMapRenderAllOrderQueues(UniverseID holomapid, bool value);
	void SetMapRenderCargoContents(UniverseID holomapid, bool value);
	void SetMapRenderCivilianShips(UniverseID holomapid, bool value);
	void SetMapRenderCrewInfo(UniverseID holomapid, bool value);
	void SetMapRenderDockedShipInfos(UniverseID holomapid, bool value);
	void SetMapRenderEclipticLines(UniverseID holomapid, bool value);
	void SetMapRenderMissionGuidance(UniverseID holomapid, MissionID missionid);
	void SetMapRenderMissionOffers(UniverseID holomapid, bool value);
	void SetMapRenderResourceInfo(UniverseID holomapid, bool value);
	void SetMapRenderSelectionLines(UniverseID holomapid, bool value);
	void SetMapRenderTradeOffers(UniverseID holomapid, bool value);
	void SetMapRenderWorkForceInfo(UniverseID holomapid, bool value);
	void SetMapRenderWrecks(UniverseID holomapid, bool value);
	void SetMapState(UniverseID holomapid, HoloMapState state);
	void SetMapStationInfoBoxMargin(UniverseID holomapid, const char* margin, uint32_t width);
	void SetMapTargetDistance(UniverseID holomapid, float distance);
	void SetMapTopTradesCount(UniverseID holomapid, uint32_t count);
	void SetMapTradeFilterByMaxPrice(UniverseID holomapid, int64_t price);
	void SetMapTradeFilterByMinTotalVolume(UniverseID holomapid, uint32_t minvolume);
	void SetMapTradeFilterByPlayerOffer(UniverseID holomapid, bool buysellswitch, bool enable);
	void SetMapTradeFilterByWare(UniverseID holomapid, const char** wareids, uint32_t numwareids);
	void SetMapTradeFilterByWareTransport(UniverseID holomapid, const char** transporttypes, uint32_t numtransporttypes);
	void SetMapAlertFilter(UniverseID holomapid, uint32_t alertlevel);
	bool SetOrderSyncPointID(UniverseID controllableid, size_t orderidx, uint32_t syncid, bool checkonly);
	void SetPlayerCameraCockpitView(bool force);
	void SetPlayerCameraTargetView(UniverseID targetid, bool force);
	void SetSelectedMapComponent(UniverseID holomapid, UniverseID componentid);
	void SetSelectedMapComponents(UniverseID holomapid, UniverseID* componentids, uint32_t numcomponentids);
	bool SetSofttarget(UniverseID componentid, const char*const connectionname);
	void SetSubordinateGroupAssignment(UniverseID controllableid, int group, const char* assignment);
	void SetSubordinateGroupDockAtCommander(UniverseID controllableid, int group, bool value);
	void SetTrackedMenuFullscreen(const char* menu, bool fullscreen);
	void SetTurretGroupArmed(UniverseID defensibleid, UniverseID contextid, const char* path, const char* group, bool arm);
	void SetTurretGroupMode2(UniverseID defensibleid, UniverseID contextid, const char* path, const char* group, const char* mode);
	void SetWeaponArmed(UniverseID weaponid, bool arm);
	void SetWeaponGroup(UniverseID defensibleid, UniverseID weaponid, bool primary, uint32_t groupidx, bool value);
	void SetWeaponMode(UniverseID weaponid, const char* mode);
	bool ShouldSubordinateGroupDockAtCommander(UniverseID controllableid, int group);
	void ShowBuildPlotPlacementMap(UniverseID holomapid, UniverseID sectorid);
	void ShowUniverseMap2(UniverseID holomapid, bool setoffset, bool showzone, bool forcebuildershipicons, UniverseID startsectorid, UIPosRot startpos);
	void SignalObjectWithNPCSeed(UniverseID objecttosignalid, const char* param, NPCSeed person, UniverseID controllableid);
	void SpawnObjectAtPos(const char* macroname, UniverseID sectorid, UIPosRot offset);
	bool StartBoardingOperation(UniverseID defensibletargetid, const char* boarderfactionid);
	void StartPanMap(UniverseID holomapid);
	void StartRotateMap(UniverseID holomapid);
	bool StopPanMap(UniverseID holomapid);
	bool StopRotateMap(UniverseID holomapid);
	void ZoomMap(UniverseID holomapid, float zoomstep);
	void StartMapBoxSelect(UniverseID holomapid, bool selectenemies);
	void StopMapBoxSelect(UniverseID holomapid);
	bool ToggleAutoPilot(bool checkonly);
	bool UpdateAttackerOfBoardingOperation(UniverseID defensibletargetid, UniverseID defensibleboarderid, const char* boarderfactionid, const char* actionid, uint32_t* marinetieramounts, int32_t* marinetierskilllevels, uint32_t nummarinetiers);
	bool UpdateBoardingOperation(UniverseID defensibletargetid, const char* boarderfactionid, uint32_t approachthreshold, uint32_t insertionthreshold);
	void UpdateMapBuildPlot(UniverseID holomapid);
]]

local function tprint(tbl, indent, endl)
	local endl = endl or '\n'
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{" .. endl
	indent = indent + 2
	if type(tbl) ~= 'table' then
		return 'Not a table: value=' .. tostring(tbl)
	end
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if (type(k) == "number") then
			toprint = toprint .. "[" .. k .. "] = "
		elseif (type(k) == "string") then
			toprint = toprint .. k .. "= "
		end
		if (type(v) == "number") then
			toprint = toprint .. v .. "," .. endl
		elseif (type(v) == "string") then
			toprint = toprint .. "\"" .. v .. "\"," .. endl
		elseif (type(v) == "table") then
			toprint = toprint .. tprint(v, indent + 2) .. "," .. endl
		else
			toprint = toprint .. "\"" .. tostring(v) .. "\"," .. endl
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

local orig = {}
local mod = {}
local menu = {}
local function init()
	--DebugError("x4_focused_pan init reached")
	for _, _menu in ipairs(Menus) do
		if _menu.name == "MapMenu" then
			menu = _menu
			local n = 0
			for k, v in pairs(mod) do
				orig[k] = _menu[k]
				_menu[k] = v
				n = n + 1
			end
			--DebugError("x4_focused_pan has installed " .. n .. " hooks")
			break
		end
	end
end

local config = {
	mapRowHeight = Helper.standardTextHeight,
	mapFontSize = Helper.standardFontSize,
	contextBorder = 5,
	layers = {
		{ name = ReadText(1001, 3252),	icon = "mapst_fs_trade",		mode = "layer_trade",		helpOverlayID = "layer_trade",		helpOverlayText = ReadText(1028, 3214)  },
		{ name = ReadText(1001, 3253),	icon = "mapst_fs_think",		mode = "layer_think",		helpOverlayID = "layer_think",		helpOverlayText = ReadText(1028, 3215)  },
		{ name = ReadText(1001, 8329),	icon = "mapst_fs_mining",		mode = "layer_mining",		helpOverlayID = "layer_mining",		helpOverlayText = ReadText(1028, 3216)  },
		{ name = ReadText(1001, 3254),	icon = "mapst_fs_other",		mode = "layer_other",		helpOverlayID = "layer_other",		helpOverlayText = ReadText(1028, 3217)  },
	},
	orderDragSupport = {
	--	order name					position parameter
		["MoveWait"]				= 1,
		["CollectDropsInRadius"]	= 1,
		["DeployObjectAtPosition"]	= 1,
		["AttackInRange"]			= 1,
		["ProtectPosition"]			= 1,
		["MiningCollect"]			= 1,
		["MiningPlayer"]			= 1,
		["Explore"]					= 2,
		["ExploreUpdate"]			= 2,
	},
	layer_trade = {
		callback = function (value) return C.SetMapRenderTradeOffers(menu.holomap, value) end,
		[1] = {
			caption = ReadText(1001, 46),
			info = ReadText(1001, 3279),
			overrideText = ReadText(1001, 8378),
			type = "multiselectlist",
			id = "trade_wares",
			callback = function (...) return menu.filterTradeWares(...) end,
			listOptions = function (...) return menu.getFilterTradeWaresOptions(...) end,
			displayOption = function (option) return "\27[maptr_supply] " .. GetWareData(option, "name") end,
		},
		[2] = {
			caption = ReadText(1001, 1400),
			type = "checkbox",
			callback = function (...) return menu.filterTradeStorage(...) end,
			[1] = {
				id = "trade_storage_container",
				name = ReadText(20205, 100),
				info = ReadText(1001, 3280),
				param = "container",
			},
			[2] = {
				id = "trade_storage_solid",
				name = ReadText(20205, 200),
				info = ReadText(1001, 3281),
				param = "solid",
			},
			[3] = {
				id = "trade_storage_liquid",
				name = ReadText(20205, 300),
				info = ReadText(1001, 3282),
				param = "liquid",
			},
		},
	}
}

local function compareCamera(c1, c2)
	dx = c1.offset.x - c2.offset.x
	dy = c1.offset.y - c2.offset.y
	dz = c1.offset.z - c2.offset.z
	dh = c1.cameradistance - c2.cameradistance
	return dx * dx + dy * dy + dz * dz + dh * dh
end


-- monitor update(): perform mid-button focusedview drag
function mod.onUpdate()
	orig.onUpdate()

	if menu.focusedpan ~= nil then
		if menu.focusedpan.start then
			local new_ms = ffi.new("HoloMapState")
			C.GetMapState(menu.holomap, new_ms)
			if compareCamera(menu.focusedpan.mapstate, new_ms) > 0.01 then
				C.StopPanMap(menu.holomap)
				menu.focusedpan.start = false
			else
				return
			end
		elseif menu.focusedpan.start == nil then
			if menu.focusedpan.lastmapstate then
				local new_ms = ffi.new("HoloMapState")
				C.GetMapState(menu.holomap, new_ms)
				if compareCamera(new_ms, menu.focusedpan.lastmapstate) > 0.01 then
					menu.focusedpan.start = true
					-- nasty workaround to cancel SetFocusMapComponent by starting panningmap first and setting map state when screen actually started panning
					C.StartPanMap(menu.holomap)
				elseif compareCamera(new_ms, menu.focusedpan.mapstate) > 1 then
					menu.focusedpan.start = false
				end
			end
		end
		local mouseposi = table.pack(GetLocalMousePosition())
		local dx = (menu.focusedpan.mouseposi[1] - mouseposi[1])*menu.focusedpan.mapstate.cameradistance/750
		local dy = (menu.focusedpan.mouseposi[2] - mouseposi[2])*menu.focusedpan.mapstate.cameradistance/750
		local cs_x = menu.focusedpan.cs_x
		local cs_y = menu.focusedpan.cs_y
		local off = menu.focusedpan.mapstate.offset
		local ms = { offset = { x = off.x + dx * cs_x[1] + dy * cs_y[1],
		                        y = off.y + dx * cs_x[2] + dy * cs_y[2],
		                        z = off.z + dx * cs_x[3] + dy * cs_y[3],
		                        yaw = off.yaw, pitch = off.pitch, roll = off.roll },
		             cameradistance = menu.focusedpan.mapstate.cameradistance }
		C.SetMapState(menu.holomap, ms)
		menu.mapstate = ms
		menu.focusedpan.lastmapstate = ms
	end
end

function mod.onRenderTargetMiddleMouseDown(modified)
	--DebugError("middle mouse down")
	menu.focusedpan = { mapstate = ffi.new("HoloMapState"),
	                    mouseposi = table.pack(GetLocalMousePosition()),
						downtime = getElapsedTime(),
						modified = modified}
	C.GetMapState(menu.holomap, menu.focusedpan.mapstate)
	local off = menu.focusedpan.mapstate.offset

	-- compute camera-space translation axis
	local sin_pitch = math.sin(off.pitch)
	local cos_pitch = math.cos(off.pitch)
	local sin_yaw = math.sin(off.yaw)
	local cos_yaw = math.cos(off.yaw)
	menu.focusedpan.cs_x = {cos_yaw, 0., -sin_yaw}
	menu.focusedpan.cs_y = {-sin_yaw*sin_pitch, cos_pitch, -cos_yaw*sin_pitch}

	--local obj = C.GetPickedMapComponent(menu.holomap)
	--menu.focusedpan.rtmouseposi = table.pack(GetRenderTargetMousePosition(menu.map))
	--AddLogbookEntry('tips', 'Object:UID=' .. ConvertStringTo64Bit(tostring(obj)) .. ',name='
	--		.. ffi.string(C.GetComponentName(obj)) .. ',class=' .. ffi.string(C.GetComponentClass(obj))
	--		.. ';\nmouse:' .. (menu.focusedpan.mouseposi[1]) .. ',' .. (menu.focusedpan.mouseposi[2])
	--		.. ';\nrtmouse:' .. (menu.focusedpan.rtmouseposi[1]) .. ',' .. (menu.focusedpan.rtmouseposi[2])
	--		.. ';\nUIPosRot:' .. table.concat({ off.x, off.y, off.z, off.yaw, off.pitch, off.roll }, ',')
	--		.. ';\ncameraDist:' .. menu.focusedpan.mapstate.cameradistance)
end

local function save_trade_wares_list()
	menu.savedTradeWares = {}
	for _, ware in ipairs(menu.getFilterOption('trade_wares')) do
		menu.savedTradeWares[ware] = 1
	end
end

local function load_trade_wares_list()
	if menu.savedTradeWares ~= nil then
		menu.setFilterOption("layer_trade", config.layer_trade[1], config.layer_trade[1].id, menu.savedTradeWares)
	end
end

function mod.onRenderTargetMiddleMouseUp()
	--DebugError("middle mouse up")
	C.StopPanMap(menu.holomap)
	if menu.focusedpan == nil then
		return
	end
	local focusedpan = menu.focusedpan
	local mouseposi = table.pack(GetLocalMousePosition())
	local modified = focusedpan.modified
	menu.focusedpan = nil

	-- if middle-click
	if getElapsedTime() - focusedpan.downtime < 0.5 and not Helper.comparePositions(focusedpan.mouseposi, mouseposi, 5) then
		local obj = C.GetPickedMapComponent(menu.holomap)
		local obj64 = ConvertStringTo64Bit(tostring(obj))
		local clsname = ffi.string(C.GetComponentClass(obj))
		if clsname == "sector" or clsname == '' then
			if modified == 'ctrl' then
				-- ctrl+click on empty space to save current trade filter list
				save_trade_wares_list()
			elseif modified == 'shift' then
				-- shift+click on empty space to load saved trade filter list, turning on trade layer if not on
				if not menu.getFilterOption('layer_trade') then
					menu.buttonSetFilterLayer('layer_trade')
				end
				load_trade_wares_list()
			else
				-- click on empty space to toggle trade mode
				menu.buttonSetFilterLayer('layer_trade')
			end
		elseif clsname == "station" then
			if not menu.getFilterOption('layer_trade') then
				menu.buttonSetFilterLayer('layer_trade')
			end
			-- trade offer
			local tradeoffers = GetComponentData(obj64, "tradeoffers")
			local cargos = {}
			for _, tradeid in ipairs(tradeoffers) do
				local trade = GetTradeData(tradeid)
				if modified == 'ctrl' then
					if trade.isbuyoffer then
						cargos[trade.ware] = 1
					end
				elseif modified == 'shift' then
					if trade.isselloffer then
						cargos[trade.ware] = 1
					end
				else
					cargos[trade.ware] = 1
				end
			end
			menu.setFilterOption("layer_trade", config.layer_trade[1], config.layer_trade[1].id, cargos)
		elseif C.IsComponentClass(obj, "ship") and GetComponentData(obj64, 'isplayerowned') then
			if not menu.getFilterOption('layer_trade') then
				menu.buttonSetFilterLayer('layer_trade')
			end
			local cargos = GetComponentData(obj64, "cargo")
			menu.setFilterOption("layer_trade", config.layer_trade[1], config.layer_trade[1].id, cargos)
			for _, option in ipairs(config.layer_trade[2]) do
				if not menu.getFilterOption(option.id) then
					menu.setFilterOption("layer_trade", config.layer_trade[2], option.id)
				end
			end
		end
		menu.refreshMainFrame = true
	end
end

function mod.createSearchField(frame, width, height, offsetx, offsety, refresh)
	local numCols = 6 + #config.layers
	local ftable = frame:addTable(numCols, { tabOrder = 4, width = width, height = height, x = offsetx, y = offsety, skipTabChange = true, backgroundID = "solid", backgroundColor = Helper.color.semitransparent })
	ftable:setDefaultCellProperties("text", { minRowHeight = config.mapRowHeight, fontsize = config.mapFontSize })
	ftable:setDefaultCellProperties("button", { height = config.mapRowHeight })
	ftable:setDefaultComplexCellProperties("button", "text", { fontsize = config.mapFontSize })

	ftable:setColWidth(1, Helper.scaleY(config.mapRowHeight), false)
	ftable:setColWidth(2, math.max(4, Helper.scaleY(Helper.headerRow1Height) - Helper.scaleY(config.mapRowHeight) - Helper.borderSize), false)
	ftable:setColWidth(3, menu.sideBarWidth - Helper.scaleY(Helper.headerRow1Height) - Helper.borderSize, false)
	for i = 2, #config.layers do
		ftable:setColWidth(i + 2, menu.sideBarWidth, false)
	end
	ftable:setColWidth(numCols - 1, Helper.scaleY(config.mapRowHeight), false)
	ftable:setColWidth(numCols, Helper.scaleY(config.mapRowHeight), false)

	-- search field
	local row = ftable:addRow(true, { fixed = true })
	-- toggle trade filter
	local colspan = 1
	if menu.editboxHeight >= Helper.scaleY(config.mapRowHeight) then
		colspan = 2
	end
	local entry = config.layers[1]
	local icon = entry.icon
	local isTradeOn = menu.getFilterOption(entry.mode)
	if not isTradeOn then
		icon = icon .. "_disabled"
	end
	local bgcolor = {r = 33, g = 46, b = 55, a = 40}
	row[1]:setColSpan(colspan):createButton({ height = menu.editboxHeight, bgColor = bgcolor, mouseOverText = entry.name, scaling = false, helpOverlayID = "toggle_trade", helpOverlayText = " ", helpOverlayHighlightOnly = true}):setIcon(icon, { })
	row[1].handlers.onClick = function () return menu.buttonSetFilterLayer(entry.mode, row.index, 1) end
	-- reset camera view
	row[colspan + 1]:setColSpan(1):createButton({ active = true, height = menu.editboxHeight, mouseOverText = ffi.string(C.GetLocalizedText(1026, 7911, ReadText(1026, 7902))), bgColor = bgcolor, scaling = false }):setIcon("menu_reset_view"):setHotkey("INPUT_STATE_DETAILMONITOR_RESET_VIEW", { displayIcon = false })
	row[colspan + 1].handlers.onClick = menu.buttonResetView
	-- save load buttons (when trade layer is on)
	if isTradeOn then
		row[2+colspan]:createButton({ height = menu.editboxHeight, mouseOverText = 'Save trade wares list', bgColor = bgcolor, scaling = false }):setText("save", {fontsize = menu.playerInfo.fontsize, halign = "center"})
		row[2+colspan].handlers.onClick = save_trade_wares_list
		row[3+colspan]:createButton({ height = menu.editboxHeight, mouseOverText = 'Load trade waves list', bgColor = bgcolor, scaling = false }):setText("load", {fontsize = menu.playerInfo.fontsize, halign = "center"})
		row[3+colspan].handlers.onClick = load_trade_wares_list
		colspan = colspan + 2
	end
	-- editbox
	row[colspan + 2]:setColSpan(numCols - colspan - 1):createEditBox({ height = menu.editboxHeight, defaultText = ReadText(1001, 3250), scaling = false, helpOverlayID = "map_searchbar", helpOverlayText = " ", helpOverlayHighlightOnly = true, restoreInteractiveObject = true }):setText("", { x = Helper.standardTextOffsetx, scaling = true }):setHotkey("INPUT_STATE_DETAILMONITOR_0", { displayIcon = true })
	row[colspan + 2].handlers.onEditBoxDeactivated = menu.searchTextConfirmed

	-- search terms
	local row = ftable:addRow(true, { fixed = true, bgColor = Helper.color.transparent })
	local searchindex = 0
	for i = 1, math.min(3, #menu.searchtext) do
		local col = i
		local colspan = 1
		if col == 1 then
			colspan = 6
		else
			col = col + 5
		end
		searchindex = searchindex + 1
		row[col]:setColSpan(colspan)
		local truncatedString = TruncateText(menu.searchtext[i].text, Helper.standardFont, Helper.scaleFont(Helper.standardFont, config.mapFontSize), row[col]:getWidth() - 2 * Helper.scaleX(10))

		if menu.searchtext[i].blockRemove then
			row[col]:createText(truncatedString, { halign = "center", cellBGColor = Helper.defaultButtonBackgroundColor })
		else
			row[col]:createButton({
				helpOverlayID = "FilterItem" .. searchindex,
				helpOverlayText = " ",
				helpOverlayHighlightOnly = true,
			}):setText(truncatedString, { halign = "center" }):setText2("X", { halign = "right" })
			row[col].handlers.onClick = function () return menu.buttonRemoveSearchEntry(i) end
		end
	end

	local setting = config.layer_trade[1]
	local warefilter = menu.getFilterOption(setting.id) or {}
	local searchindex = 0
	if #menu.searchtext < 3 then
		for i = 1, math.min(3 - #menu.searchtext, #warefilter) do
			local col = i + #menu.searchtext
			local colspan = 1
			if col == 1 then
				colspan = 6
			else
				col = col + 5
			end
			searchindex = searchindex + 1
			row[col]:setColSpan(colspan)
			local truncatedString = TruncateText(GetWareData(warefilter[i], "name"), Helper.standardFont, Helper.scaleFont(Helper.standardFont, config.mapFontSize), row[col]:getWidth() - 2 * Helper.scaleX(10))

			row[col]:createButton({
				helpOverlayID = "FilterWare" .. searchindex,
				helpOverlayText = " ",
				helpOverlayHighlightOnly = true,
			}):setText(truncatedString, { halign = "center" }):setText2("X", { halign = "right" }):setIcon("maptr_supply", { width = Helper.standardTextHeight, height = Helper.standardTextHeight })
			row[col].handlers.onClick = function () return menu.removeFilterOption(setting, setting.id, i) end
			row[col].properties.uiTriggerID = "removefilteroption"
		end
	end

	if (#menu.searchtext + #warefilter) > 3 then
		row[5 + #config.layers]:setColSpan(2):createText(string.format("%+d", (#menu.searchtext + #warefilter) - 3))
	else
		row[5 + #config.layers]:setColSpan(2):createText("")
	end

	if menu.searchTableMode then
		if menu.holomap ~= 0 then
			C.SetMapStationInfoBoxMargin(menu.holomap, "right", menu.infoTableOffsetX + menu.infoTableWidth + config.contextBorder)
		end
		if (#menu.searchtext + #warefilter) > 0 then
			local row = ftable:addRow(true, { fixed = true, bgColor = Helper.color.transparent })
			row[1]:createText("")
		end

		if menu.searchTableMode == "filter" then
			menu.createFilterMode(ftable, numCols)
		elseif menu.searchTableMode == "legend" then
			menu.createLegendMode(ftable, numCols)
		elseif menu.searchTableMode == "hire" then
			menu.createHireMode(ftable, numCols)
		end
	else
		if menu.holomap ~= 0 then
			C.SetMapStationInfoBoxMargin(menu.holomap, "right", 0)
		end
	end
	if not refresh then
		menu.createInfoFrame2()
	end
end

function mod.onRenderTargetMouseDown(modified)
	if menu.currentMouseCursor == 'trade' or menu.infoTableMode == "plots" then
		return orig.onRenderTargetMouseDown(modified)
	end
	menu.leftdown = { time = getElapsedTime(), dyntime = getElapsedTime(), position = table.pack(GetLocalMousePosition()), dynpos = table.pack(GetLocalMousePosition()) }

	local pickedorder = ffi.new("Order")
	local buf = ffi.new("bool[1]", 0)
	local pickedordercomponent = C.GetPickedMapOrder(menu.holomap, pickedorder, buf)
	local isintermediate = buf[0]
	if pickedordercomponent ~= 0 then
		local orderdef = ffi.new("OrderDefinition")
		if C.GetOrderDefinition(orderdef, pickedorder.orderdef) then
			local orderdefid = ffi.string(orderdef.id)
			if isintermediate or config.orderDragSupport[orderdefid] then
				menu.orderdrag = { component = pickedordercomponent, order = pickedorder, orderdefid = isintermediate and "MoveWait" or orderdefid, isintermediate = isintermediate, isclick = true }
			end
		end

		if menu.mode ~= "orderparam_object" then
			if not modified then
				menu.infoSubmenuObject = ConvertStringTo64Bit(tostring(pickedordercomponent))
				if menu.infoTableMode == "info" then
					menu.refreshInfoFrame(nil, 0)
				elseif menu.searchTableMode == "info" then
					menu.refreshInfoFrame2(nil, 0)
				end
			end
		end
	else
		if modified == "shift" then
			C.StartMapBoxSelect(menu.holomap, menu.mode == "orderparam_selectenemies")
		else
			local obj = C.GetPickedMapComponent(menu.holomap)
			local clsname = ffi.string(C.GetComponentClass(obj))
			if clsname == "sector" or clsname == '' then
				C.StartPanMap(menu.holomap)
				menu.panningmap = { isclick = true }
			else
				menu.panningmap = { isclick = true }
				C.SetSelectedMapComponent(menu.holomap, obj)
				menu.addSelectedComponent(obj, true)
			end
		end
	end
end

function mod.buttonResetView()
	if menu.holomap and (menu.holomap ~= 0) then
		C.ResetMapPlayerRotation(menu.holomap)

		local obj = C.GetPickedMapComponent(menu.holomap)
		local clsname = ffi.string(C.GetComponentClass(obj))
		if clsname == "sector" or clsname == '' then
			local components = {}
			Helper.ffiVLA(components, "UniverseID", C.GetNumMapSelectedComponents, C.GetMapSelectedComponents, menu.holomap)
			if #components > 0 then
				C.SetFocusMapComponent(menu.holomap, components[1], true)
			else
				C.SetFocusMapComponent(menu.holomap, C.GetPlayerObjectID(), true)
			end
		else
			C.SetFocusMapComponent(menu.holomap, obj, true)
		end

		if menu.infoTableMode == "objectlist" then
			menu.refreshInfoFrame()
		end
	end
end

function mod.prepareInfoContext(rowdata, instance)
	if (type(rowdata) == "table") and (rowdata[1] == "info_crewperson") and (type(rowdata[3]) == "number")
			and C.IsComponentClass(rowdata[3], "controllable") and GetComponentData(rowdata[3], "isplayerowned") then
		local controllable = rowdata[3]
		local person = rowdata[2]
		if (not pcall(C.IsPerson, person, controllable)) and (not pcall(C.GetInstantiatedPerson, person, controllable))
				and (not pcall(C.GetPersonRole, person, controllable)) and (not pcall(C.IsPersonTransferScheduled, controllable, person)) then

			-- Create context menu for easy hire
			local x, y = GetLocalMousePosition()
			local xoffset = x + Helper.viewWidth / 2
			local yoffset = Helper.viewHeight / 2 - y
			menu.contextFrame = Helper.createFrameHandle(menu, {
				x = xoffset - 2 * Helper.borderSize,
				y = yoffset,
				width = menu.selectWidth + 2 * Helper.borderSize,
				layer = 3,
				backgroundID = "solid",
				backgroundColor = Helper.color.semitransparent,
				standardButtons = { close = true },
				closeOnUnhandledClick = true,
			})
			local frame = menu.contextFrame
			local loctable = frame:addTable(1, { tabOrder = 3, x = Helper.borderSize, y = Helper.borderSize, width = menu.selectWidth })
			-- NPC name
			local row = loctable:addRow(false, { fixed = true })
			local npcname = GetComponentData(person, "name")
			row[1]:createText(npcname, Helper.headerRowCenteredProperties)
			-- set guidance
			local row = loctable:addRow("info_person_setguidance", { fixed = true, bgColor = Helper.color.darkgrey })
			row[1]:createButton({ bgColor = Helper.color.transparent, height = Helper.standardTextHeight }):setText(string.format(ReadText(1016, 10101), npcname))
			row[1].handlers.onClick = function () menu.plotCourse(ConvertIDTo64Bit(person)); Helper.closeMenu(menu); menu.cleanup() end
			-- work somewhere else
			local row = loctable:addRow("info_person_worksomewhere", { fixed = true, bgColor = Helper.color.darkgrey })
			row[1]:createButton({ bgColor = Helper.color.transparent, height = Helper.standardTextHeight }):setText(ReadText(1002, 3008))
			row[1].handlers.onClick = function () Helper.closeMenuAndOpenNewMenu(menu, "MapMenu", { 0, 0, true, controllable, nil, "hire", { "signal", person, 0} }); menu.cleanup() end
			-- fire
			local row = loctable:addRow("info_person_fire", { fixed = true, bgColor = Helper.color.darkgrey })
			row[1]:createButton({ bgColor = Helper.color.transparent, height = Helper.standardTextHeight }):setText(ReadText(1002, 15800))
			row[1].handlers.onClick = function () menu.infoSubmenuFireNPCConfirm(controllable, person, person, instance) end
			-- adjust frame position
			local neededheight = loctable.properties.y + loctable:getVisibleHeight()
			if frame.properties.y + neededheight + Helper.frameBorder > Helper.viewHeight then
				yoffset = Helper.viewHeight - neededheight - Helper.frameBorder
				frame.properties.y = yoffset
			end
			-- only add one border as the table y offset already is part of frame:getUsedHeight()
			frame.properties.height = math.min(Helper.viewHeight - frame.properties.y, frame:getUsedHeight() + Helper.borderSize)
			frame:display()
			return
		end
	end

	orig.prepareInfoContext(rowdata, instance)
end

function mod.createUserQuestionContext(frame)
	if pcall(C.GetPersonName, menu.contextMenuData.person, menu.contextMenuData.controllable) then
		orig.createUserQuestionContext(frame)
	else
		if menu.arrowsRegistered then
			UnregisterAddonBindings("ego_detailmonitor", "map_arrows")
			menu.arrowsRegistered = nil
		end

		local ftable = frame:addTable(5, { tabOrder = 5, reserveScrollBar = false })

		local row = ftable:addRow(false, { fixed = true, bgColor = Helper.color.transparent })
		row[1]:setColSpan(5):createText(string.format(ReadText(1001, 11202), GetComponentData(menu.contextMenuData.person, "name")), Helper.headerRowCenteredProperties)

		local row = ftable:addRow(false, { fixed = true, bgColor = Helper.color.transparent })
		row[1]:setColSpan(5):createText(ReadText(1001, 11201))

		local row = ftable:addRow(false, { fixed = true, bgColor = Helper.color.transparent })
		row[1]:setColSpan(5):createText("")

		local row = ftable:addRow(true, { fixed = true, bgColor = Helper.color.transparent })
		row[2]:createButton():setText(ReadText(1001, 2617), { halign = "center" })
		row[2].handlers.onClick = function () return menu.infoSubmenuFireNPC(menu.contextMenuData.controllable, menu.contextMenuData.entity, menu.contextMenuData.person, menu.contextMenuData.instance) end
		row[4]:createButton():setText(ReadText(1001, 2618), { halign = "center" })
		row[4].handlers.onClick = menu.closeContextMenu
	end
end

function mod.infoSubmenuFireNPC(controllable, entity, person, instance)
	if not pcall(orig.infoSubmenuFireNPC, controllable, entity, person, instance) then
		SignalObject(person, "npc__control_dismissed")
		menu.closeContextMenu()
		if menu.infoMode.left == "objectcrew" then
			menu.infoSubmenuPrepareCrewInfo("left")
			menu.refreshInfoFrame(nil, 0)
		end
		if menu.infoMode.right == "objectcrew" then
			menu.infoSubmenuPrepareCrewInfo("right")
			menu.refreshInfoFrame2(nil, 0)
		end
	end
end

function mod.onTableRightMouseClick(uitable, row, posx, posy)
	if menu.infoTableMode == "info" and row == 2 then
		local components = {}
		Helper.ffiVLA(components, "UniverseID", C.GetNumMapSelectedComponents, C.GetMapSelectedComponents, menu.holomap)
		if #components > 0 then
			C.SetFocusMapComponent(menu.holomap, components[1], false)
		elseif menu.lastSelectedShip ~= nil then
			C.SetFocusMapComponent(menu.holomap, menu.lastSelectedShip, false)
			C.SetSelectedMapComponent(menu.holomap, menu.lastSelectedShip)
			menu.infoSubmenuObject = menu.lastSelectedShip
			AddUITriggeredEvent(menu.name, "selection_" .. (menu.lastSelectedType), menu.lastSelectedShip)
			menu.selectedcomponents[tostring(menu.lastSelectedShip)] = {}
			menu.updateTableSelection()
			menu.refreshInfoFrame(nil, 0)
		end
	end

	return orig.onTableRightMouseClick(uitable, row, posx, posy)
end

function mod.addSelectedComponent(component, clear, noupdate)
	local compo64 = ConvertStringTo64Bit(tostring(component))
	if GetComponentData(compo64, "isplayerowned") then
		local clsname = ffi.string(C.GetComponentClass(compo64))
		if clsname == 'station' then
			menu.lastSelectedType = clsname
			menu.lastSelectedShip = compo64
		elseif string.sub(clsname, 1, 4)=='ship' then
			menu.lastSelectedType = 'ship'
			menu.lastSelectedShip = compo64
		end
	end
	return orig.addSelectedComponent(component, clear, noupdate)
end

init()
