Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379ABCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 06:32:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25D5040276;
	Wed, 20 May 2026 08:32:42 +0200 (CEST)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023095.outbound.protection.outlook.com
 [40.107.44.95]) by mails.dpdk.org (Postfix) with ESMTP id 571A64025E
 for <dev@dpdk.org>; Wed, 20 May 2026 08:32:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjqtpjGFv6pxC6Vi76XaA/qCfsptZVaxDdcmwM7comFel+WaM5klkG9FVP0VZyJjihv5B0tn5jYgTm4X7AFXrarG3WjwlPtvMu+fu9CLZYDYQVkGr1iUbNOwMS0sBHJpjP/4Wpc1v6baMK/t3Y/lJNSRLihQl2D9T0c1psfE2jsw3jHCC/HebXVcGayskcc4gIfhUCOK3X2Lfl3/5jlhTpw9PDEZoprQMJ+dq0BhIU1G61HDFT/FFzH5/rnM+fbRoKJiUX1ml8kM4CEIIvICisabpo7I4sYKTRmEExuzXRIsTE2zeZekJ7HoMAfiGmCJvT4GUdGaV608DK+Rsq/gIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CofRu6HpQxQuMhKm3PXIXVkTwlzpwFYwkM73Pyqmf3o=;
 b=LTuU3MmvrLbWv9+30D6el3zpg1c3HUTjDcj1zqp3cRLVK7s1qZ9TqGXDGuKlyhli2kKIuXVH3HsmLZbByb+xAcyjhjyMVDL/USsDy2pM9MPDKiqkVy07tow0idTCrERtd8QnD9+M4tm78pdgG5d8+Hxrj+1EP6xnW0aVhiz//GaSXRYXm8J+Y5SBxU28ndU8iAL/PFOe2D0MEwGC2tf376dssQIrvFq5bDxFqzzeUn8M7kOw81wQXiJ3loz4G95cscekJ1f+kasJCRyHDvqHia/4wlnE6tWt9WfX0+ROmYkNIQeJ2oT8zki5lyYcBCTUhIyVeAUbWyPSyfgtsx6TyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CofRu6HpQxQuMhKm3PXIXVkTwlzpwFYwkM73Pyqmf3o=;
 b=gcupmXqYap9mlOzyoK375tyBlyGZ3DjSns/46f4KEy1Hm1fnSy8V9t5dDRaNm62rSF8722eUOeI9l15lCJtPPGs+FSQI+OhrLo6yZl2bU+M1tvfFCTsuwCcwjk31FPwdQLFTJgec4sGXZMUuzJb8cC/J3BsKyB5KMI1QcWsSBvw=
Received: from SIAP153MB1149.APCP153.PROD.OUTLOOK.COM (2603:1096:4:293::9) by
 KUXP153MB1945.APCP153.PROD.OUTLOOK.COM (2603:1096:d10:a8::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.1; Wed, 20 May 2026 06:32:13 +0000
Received: from SIAP153MB1149.APCP153.PROD.OUTLOOK.COM
 ([fe80::4eff:9301:cf1e:aed6]) by SIAP153MB1149.APCP153.PROD.OUTLOOK.COM
 ([fe80::4eff:9301:cf1e:aed6%4]) with mapi id 15.21.0071.005; Wed, 20 May 2026
 06:32:13 +0000
From: Wei Hu <weh@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: Long Li <longli@microsoft.com>, dpdk <dev@dpdk.org>, Wei Hu
 <weh@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/1] net/mana: add device reset support
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/1] net/mana: add device reset support
Thread-Index: AQHc33lSFlx1D0JQm0ihIzxbVXsbmbYTM5AAgAKG0zCAALo5oA==
Date: Wed, 20 May 2026 06:32:13 +0000
Message-ID: <SIAP153MB114940591490FC0BBF8A6216BB012@SIAP153MB1149.APCP153.PROD.OUTLOOK.COM>
References: <20260509060113.61686-1-weh@linux.microsoft.com>
 <20260509060113.61686-2-weh@linux.microsoft.com>
 <20260517204858.7a8a9200@phoenix.local>
 <SA1PR21MB66836A17CA584763D4D3F8A6CE002@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB66836A17CA584763D4D3F8A6CE002@SA1PR21MB6683.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=77ab1088-4a7d-4432-8180-5c4c5761ec67;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-05-19T18:24:02Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SIAP153MB1149:EE_|KUXP153MB1945:EE_
x-ms-office365-filtering-correlation-id: 5327b415-9e57-418c-0070-08deb6398774
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021|11063799006|4143699003;
x-microsoft-antispam-message-info: NX2EKrK0OgXtfQIUpSp4m0MfyMC1IsMRnHTQ7S0P+WhXP7Me9bntsfWlkUlVMH1UU3YChBFSO97neF+qw6qbfTEBhr+e0vVb+7RaTrc24lK9J53LFwG1lK9GEC9u9STrH2pvq+dPF0L0hg8w0S/Fvs+MUppOIt+liyutEWYnc2FWAcQCqtyuPXlzZJj2fKjHOcXxgpkT2j30gFjT+qkBuadbXvE9PVMzAZg6diCP0GZvZ61670WkYm7H2UtexaB7ZC0s3/eLRgBn+Wc15zuoQqbAdB1JgT7Erp6EZqTveV/92qj3lXjelWdyj3EKPVYsL7kuTc500Ua1ipUxWCgoa8pOou9PyNoFyx8ORABu+xEi2JK0Y4awJ0PPlHHE4fF8QiESr1rF+EtrHZjg3qp9hkf1X2YlpfU77/W5TQ5dLc45o3foF94X+QB7qZ3mt/QWor0d+LCMQXyldC6xwW1B0fX36KDSjjLkt0YV6Rk+2ujoCjOlXvqP8j8Q3NNmWQRBl/VCELD33cQcyR+GQyxdoh4LlFA+LvuUW7q1toNEjGJJKwnkofZTOB8sqrwg2iUaKmmHKc5HKN0sHBUdJjGiXs+8q/B080S1x2Ugj9pdtuqNVgHcdbOFEHYgh7ycHfjcZoqTQyRIW4m4vCCYWqAy3qH2AZRVZ29pvkiv+h2cfDp3Awvm7JYdpduxP6frn/VLY2X2HsxshV0MNxvEXrKb79f6XLptG99OxBk/dfF1Icau66yhNmyzs1o1FcR0aMfv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SIAP153MB1149.APCP153.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(11063799006)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5c5RVVupYa6sltFsBJd3ilxpE/6S7G4c2QhaMEraiHc1jBPH31vfLNI6TmdE?=
 =?us-ascii?Q?X0hBF7y/MLQ5YAxMdCRoGyZqQQsxe+PvGTZLumUrIJ7joiYLxIZ0s8B5xEX7?=
 =?us-ascii?Q?BB+3rm2JgJboW0bdebPYaduBwbdwOnjG2tw5Nd9o70CBKKrmAzFzCL1xPFFM?=
 =?us-ascii?Q?BNoUx21g5ghFP4J8Q7AQ2+zmDsyM03UyX35Mxp7sdKdtyVgvjnMH4uuxHING?=
 =?us-ascii?Q?O9WhaH/SBK/hozgEoc/QSl9Gx6iXhQ+XJlw+E9Q5eWsiowML47adu6YuAD48?=
 =?us-ascii?Q?Ic1pA4NVcZxi5XhmM2AksPPdqe1Gtnt4qLThN4oVbpPyOEwIi7+0D9CW7rLA?=
 =?us-ascii?Q?0xwgjRDoiwl8sKWq2SwBmHVdr754KPHmI/0tGN5jUfur3+93+y0Du2kJvOuW?=
 =?us-ascii?Q?kzSKhNTymbB1dmDeZTfCfI00/F/MhTVj7VsSdnRNQ1Cts4i5tf5xA4/CvZq9?=
 =?us-ascii?Q?w9yJbK8UpvyMQpNFzUFGeFRhdciAuZ0SgqVg5CTY3BD2BM2Tb+40i9jkdFtX?=
 =?us-ascii?Q?sBkUHu+wDsoKQGd1eN7y5hwLsZZWtUzJ5c2W4cNTnPQSuhJnocCrqlnsXIYp?=
 =?us-ascii?Q?vhHD22U6c6Dp7S79VWqY86y4ov58jO29AeSmpy9VSQCQ4AnpTM7mYvF/gudr?=
 =?us-ascii?Q?kYjayOf5EF1kti8amMoFlGTiJVYcV2iMC9hers+6MhihpVNRWfcab8gabT1g?=
 =?us-ascii?Q?D1GuvWA3H1ldME0pGK0TDrsxAnlc2pyf9ZRMp/o+UAKEiMelBbbAvxlLNRTp?=
 =?us-ascii?Q?8jD4TMrwq6IkCGNrnUJcR7+1KZ1YMaOP15NceXXp5FbaLGNNuonKefiOzZ9+?=
 =?us-ascii?Q?iLCkHp4orQjb41A6GOQtmy98oCRQDXqic4rwAV2D3NEpMsbNkSQ4ygeaMWmr?=
 =?us-ascii?Q?Q7NoXTH/FdauUl2dryXbVdqf4/SCdUlthO/k8sxR6rqqKQtH1GkzltF+vwPj?=
 =?us-ascii?Q?5vbPC++ayUvSb71sxc2DcHRM1sCaMTjdWiFpO36+4wHiWDex1k192AV/ZXRF?=
 =?us-ascii?Q?8ZbcjZqNot3D09yg2ACQ4RjLhZqkfroy2SS2Uis7jqUCrpuEO84A6Uvd37xK?=
 =?us-ascii?Q?A7gSV4jRpVB4SpvJbM0GKz64bXl/Hu+9I4V/1dAydprga8ZuT51mf8V/fGXu?=
 =?us-ascii?Q?nBdGNga3+5Kq1XmNn8lgc4fHpjS+Un7q7B3OhqOe2exoLn31/R4OrDcyF5Az?=
 =?us-ascii?Q?PDHs7+4fDDxcZSCFbwdtIsSlC71VUkBMKNTDhNb2NwLlnmnZPC+gC1fnHRnx?=
 =?us-ascii?Q?14o7u9I8waN1LBGeOm+Yvt3eHY1yns48Zsc7B3hePFjto8yGeR4gHhLHSzJa?=
 =?us-ascii?Q?BfhOP/Mx6oohoGNN0SXuOqwnbC8PC7+gZ+bDxckMdTrSnbn7+ggcEOd0GdtM?=
 =?us-ascii?Q?sHnOqrGwbMtVwVuQ8pYdlzsWbeJoigPBMLsGzuHTGU/yndEowDCdMj7b0j/k?=
 =?us-ascii?Q?8nE+ZKlILNJA/mm+RCpUGbgNpm6zIaarXFpW+Ne0/BcOg4cILXm9PKJx2IEy?=
 =?us-ascii?Q?tGH4HF3yXUw36RURTVwe5bvheyfinnjF3PXWqK4noHmqqTjHTTrvJLuwC1h6?=
 =?us-ascii?Q?Dd+OwEn75oidXFGHIo9ZRdryPFDTi/JJH+wPBCUnn2MWrlxD/zqPq1Kez4R0?=
 =?us-ascii?Q?zSUrKX96jnyh5TfNoON8znoSCWyrGjQFj4NRLY7MpneHCI27zUTR7/qSXMfq?=
 =?us-ascii?Q?f8SL3L4Fz+bVSpxVVkF6xXWQVAmGvDSol6RfEacaTMFZJsHT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SIAP153MB1149.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5327b415-9e57-418c-0070-08deb6398774
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 06:32:13.4738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bMDnCfeXurXiOR3SdtPKxPtX/Ny5T/jzrcMQ2QU0YhGiNjhMn4KmCBjfScRNx8G0vSnF5Ika5rmSIgu8KPJPJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXP153MB1945
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Hi Stephen,

Many thanks for the review. I will send out a v3 to address most of them.=20
In the meantime, I would like to discuss further about two points from the
 review comments. Please see my input below.

> -----Original Message-----
> 3. Spinlock held across blocking operations.
>
>    priv->reset_ops_lock is rte_spinlock_t and is held across:
>
>      - mana_reset_enter:      mana_dev_stop, mana_dev_close,
>                               ibv_close_device,
>                               mana_mp_req_on_rxtx (5s IPC timeout)
>      - mana_reset_exit_delay: ibv_close_device, mana_pci_probe,
>                               mana_mp_req_on_rxtx, mana_dev_start
>
>    IPC with a 5-second timeout and device probe under a spinlock is
>    not acceptable.  Use a sleeping mutex (pthread_mutex_t initialized
>    with PTHREAD_PROCESS_SHARED, since priv is in shared memory), or
>    split the lock so the long operations run outside it.
>

The concern about holding rte_spinlock_t across blocking operations
is well noted. However, in the current design this works correctly, for
the following reasons:

1. mana_reset_enter runs on the EAL interrupt thread in response
   to IBV_EVENT_DEVICE_FATAL. The device is already in a fatal
   error state - the blocking IB verbs calls (ibv_close_device,
   ibv_dealloc_pd) and IPC (mana_mp_req_on_rxtx) are unavoidable
   teardown steps that must complete before recovery can begin.

2. The ethdev operations (configure, queue_setup, rss_hash_update,
   etc.) all use rte_spinlock_trylock and return -EBUSY immediately
   if the lock is held. They never spin-wait on the lock during
   reset, so there is no starvation or latency impact on the
   application threads.

3. dev_stop_lock and dev_close_lock use blocking rte_spinlock_lock,
   but they first join the reset thread (which releases the lock
   when done), so by the time they attempt to acquire the lock,
   the reset path has already released it. IMHO, the actual spin-wait
   is negligible.

4. The mana_reset_exit_delay path (re-probe, re-start) also holds
   the lock, but this runs on a dedicated control thread where
   blocking is acceptable. No data path or application thread is
   affected.

The net effect is that the spinlock is held for an extended period
only on the interrupt thread and the reset control thread - neither
of which are latency sensitive. Application threads never block on
the spinlock.

That said, switching to pthread_mutex_t with PTHREAD_PROCESS_SHARED
is a valid improvement that would make the locking more conventional
and avoid any theoretical busy-wait concerns. I can make this change if=20
it is still desirable. I would like to know your thoughts on this.

> Warnings
> --------
>
> 5. Secondary data path has no synchronization with the doorbell unmap.
>
>    MANA_MP_REQ_RESET_ENTER causes the secondary MP handler to
> munmap
>    proc_priv->db_page and set it to NULL.  The secondary's rx_burst /
>    tx_burst protect themselves only with an atomic state check:
>
>        rte_rcu_qsbr_thread_online(dstate_qsv, tid);
>        if (state !=3D MANA_DEV_ACTIVE || !db_page) { ... return 0; }
>
>    But the qsbr only has primary threads registered (registration
>    happens in mana_dev_configure, which never runs in secondary), so
>    thread_online/offline in secondary do not block the primary's
>    qsbr_check.  The MP handler in secondary therefore unmaps db_page
>    while a peer secondary lcore can still be inside rx/tx_burst with
>    a stale pointer.  Result: SIGSEGV on the next doorbell write.
>
>    The secondary needs its own quiescence mechanism (a per-process
>    qsbr or a reader-side rwlock around the data path that the MP
>    handler acquires before unmap).
>
The concern is based on the assumption that "the qsbr only has
primary threads registered (registration happens in
mana_dev_configure, which never runs in secondary)". This seems
incorrect.

My understanding is when the primary starts, the total number of queues
for primary and all secondaries is already known, which is stored in
priv->num_queues by the time mana_dev_congiure() is called. =20

The RCU thread IDs are per-queue, not per-process. In mana_dev_configure,=20
I am assigning tids used in rte_rcu_qsbr_thread_online/offline as:

  - RX path: tid =3D rxq->rxq_idx        (0 to num_queues-1)
  - TX path: tid =3D num_queues + txq_idx (num_queues to 2*num_queues-1)

These queue structures (rxq, txq) live in shared hugepage memory
via dev->data->rx_queues[] and dev->data->tx_queues[]. The QSV
itself (priv->dev_state_qsv) is also in shared hugepage memory
(allocated with rte_zmalloc_socket). So both primary and secondary
processes operate on the same QSV with the same thread IDs.

The rte_rcu_qsbr_thread_register call in mana_dev_configure
registers IDs 0..2*num_queues-1, which covers every queue
regardless of which process polls it. I think in DPDK
a given queue is polled by only one lcore at a time, so whether=20
that lcore is in the primary or a secondary process, it uses the=20
same tid for the same queue.

The reset synchronization flow is:

  1. mana_reset_enter sets dev_state =3D MANA_DEV_RESET_ENTER
  2. Calls rte_rcu_qsbr_check to wait for all registered threads
  3. Secondary lcores polling rx/tx_burst see dev_state !=3D ACTIVE,
     call rte_rcu_qsbr_thread_offline, and return 0
  4. Only after ALL threads (primary and secondary) are quiescent
     does rte_rcu_qsbr_check return success
  5. Then mana_reset_enter proceeds to stop queues and send
     MANA_MP_REQ_RESET_ENTER to unmap secondary doorbells

At step 5, no secondary lcore can be inside the data path with
a stale doorbell pointer - the RCU quiescence check at step 2-4
guarantees this. The secondary MP handler unmaps db_page only
after all secondary data path threads have exited.

So, in my opinion, this works correctly for secondaries as well.=20

Thanks,
Wei
