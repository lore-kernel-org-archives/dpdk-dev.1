Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD5BC282D1
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 02:23:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 386AC40A75;
	Fri,  7 Mar 2025 03:23:01 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2101.outbound.protection.outlook.com [40.107.212.101])
 by mails.dpdk.org (Postfix) with ESMTP id 34D5F4029E;
 Fri,  7 Mar 2025 03:22:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua4WBRqEur1E/eVGC6LMzNGU2s9GMg8ecm5l3vtcAk/VdRXwcDygZ54DIzYkOKARKLRKErCWsz//V1paOofN8FiFfH+CnusXg/XXKu3QwHonGW8fIxbggYzIU3aOvvtGOehhI6xXCYLIzVv0MxmshhfZwmYdu9mBuPhQZFEXf07iX1bWiQ1j7kMS2QmQac96bSUzxEwTPSKo0LKB7DqFSZGNahTrIC8HzywfpMP08tHxR7Rn57okxlXcfs4imDLXLUAa8LqiOq6AsFLrIQbQp5dnYwK8qr0LfO4z7Uv9zlSkz/vdb/SA9omx6IGhRbbBnfzuSM7AP4kDHAuADy/89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toEqHXZbs0rR23rNzakF0dyJUie/gsdZkiOX21bXPNg=;
 b=NNjyAo9qVUDHl141+ghwnM/j3BCNmfg0vxb6Xj8Is0F7AtbW4QcpB0+SyZmHMss4vfoPs23umHSKKHFsu8REP7Q+ngerGKFJsMF6SpLXTZubciftVlXhtHbKpsJ3BkkryuIXUnKK0X1z0LfWh5pUvofemR/dEho31W+YemQ+UcvWC2RpbO5tGj6BOgoAH2bBla+s07FhX4YUEC0SLQAz4CB4e4oeLJMqY+b1H3GCetavifucSxc6ij+PuVfZ9B7z0XVbkR1PjPFJwp0bORl6upbx2LQs/GEV25w0NQKKv+FroVcMtIf7qne/t4XaL3failfzqQ3kIpWiOzXNUiqREg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toEqHXZbs0rR23rNzakF0dyJUie/gsdZkiOX21bXPNg=;
 b=baABU4hrQXePD7BBGPiY6NJ4tE5Jf0btDR79jm6jvVzOx02lGo1xx0lDQCw29FnUZSmPAi4Uzi7IwcIW0cG17uE90FG0u1Q1r0+Ze4lskFdyX3matrUUAnXh6YfdyKYe0KoyVA6oRsShsp8IehJnzH8d1lu/Oeb0fY8BraTmtsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by BY5PR13MB3778.namprd13.prod.outlook.com (2603:10b6:a03:226::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 02:22:54 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:22:54 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Zerun Fu <zerun.fu@corigine.com>,
 chaoyong.he@corigine.com, stable@dpdk.org, Long Wu <long.wu@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH] net/nfp: add PF ID to the firmware load command
Date: Fri,  7 Mar 2025 10:22:35 +0800
Message-ID: <20250307022235.2003386-1-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|BY5PR13MB3778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8a277c-e0a6-451d-35b8-08dd5d1ef7c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k5hcYMp3V54fK4AoBzgnWu4RabnCsMFms6aCKDMFyJW6JwNXltOIWKzRoFCw?=
 =?us-ascii?Q?ZpVw4HtSrzDvP6SbLHXo3CiDC1Syrgg6JVRnD1mk6uRgRap4GzDqLTuawg9q?=
 =?us-ascii?Q?TjpiE624rkMCM90+1+CvUn9gn+bteNw2XbX8npRzfi1vUH6Rzdv4j+7yZRnY?=
 =?us-ascii?Q?ivhlKnCdO3jTpeEeO+iAxEMR0kDNBItncx63ELL+Is5oT5pHdXpCYlNYWPxO?=
 =?us-ascii?Q?dlv5x7z/DK0AmAY3Utg1e2Gn1sXFMws7kvJ9WWjP7B4ue4OVM1x7cZ9VsHGE?=
 =?us-ascii?Q?5pfLv9X9cKlIsmFHhpsxM0dMj3TpZnyNmSXe2RCn3dvEtscx7oqnAKXbq07O?=
 =?us-ascii?Q?C6wc23J8Pz4Fxt2qq/pp+X1o5YjbU2ujtPVrRvti//oEmDK/umElLPu1/WKt?=
 =?us-ascii?Q?SCKQaLHyRSqwzohbbjiP88YlZhAGMMxYkGu9pdlVNC4WPxgmP2YPMbRwGCmY?=
 =?us-ascii?Q?oEuMarWtap38GTJCkvmmJTMdsU6QLDhnW7f20eKGiIr2TSNzeC1xUbrzROZZ?=
 =?us-ascii?Q?CULcY9DgW5OB+wN/yqlIuYR7jiPf4Ylu8slysGUJPxS3ws46OY2EHs2SlPwt?=
 =?us-ascii?Q?6e1lwhSzE8jTybkg0X750cdVOmOuXEtjcldlhQpCcnVwrbAJtnBhqCK8R+XB?=
 =?us-ascii?Q?Na5LU7CvQvvt+QiA5X1PnMTOm5prQHRoRNOINqbGODypzcajIAx8uOCy9eFr?=
 =?us-ascii?Q?+2xt+Hu+HJt56UpCMCUmjzCYVv5VZar97DsnEwXY7cXpDCZxMVlIre+DtPkQ?=
 =?us-ascii?Q?f6kr18foPzHv8XX6r/ozU78nU6m3rI7VuAlQLHHApUyTfwH2rR2sS3EDdgCi?=
 =?us-ascii?Q?JuylMzXOpHaNE5aB8L19J1diuRzaRXwnUunxV+faFsJtec9NiqPZqQk7OiVk?=
 =?us-ascii?Q?MgDNmFoIE4NJ+tKKZZw5+8QrjUPekEmd+SD47yCS9XGIAQHZtaCwAM+2Uk7N?=
 =?us-ascii?Q?Ywq1M5/4HfB8b2JWKzSjjC8vU6bo52I2ZQse1FKgrridvW9CTti2JqCSeTwl?=
 =?us-ascii?Q?Bd7+wmcFUDCT7oYV3st058CpLcMSsXzTWeFveP/Ox19PdKjaysCSYc8ZA0mJ?=
 =?us-ascii?Q?dKfsyX63v462tadIkbtip5Kp1ZEULSnjsNb5+au7FaGHErmA8UYZQw7MwaSo?=
 =?us-ascii?Q?SoS06H6asSlOuGcbha1Me2b3f7XxJvnP/CEnlK6NN/61zc9jzyI0FmCfzw05?=
 =?us-ascii?Q?zI+a+mtEDrpJYEwplXFRo51sXxa0VT1b2CiCfRvWBxRGXqzRk5pYGqRJxXPn?=
 =?us-ascii?Q?oAW66+VMm7zPzE6BEKuYNO2FZ7E7DEJtjJSK0xMnbdYOmCRAG0OgdSJvlVAd?=
 =?us-ascii?Q?nwBzTqsd6wEs9pmGkMflpZNOWoovByES5fq3VNgq5BxDGKAG7IssZ8ZOQRc2?=
 =?us-ascii?Q?yv3bWlzFmvy/vrqBEf3pltGuAh+F7Pzpgnm/6wqabAbV7k+gjR/c8ksu+FPA?=
 =?us-ascii?Q?HnTm5e8pzRWkNzUY91o83zWgd4ba3Gun?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Pt1Q/j4OPVUavqoPR1enk1N5P6UZcMfhcA0jYi5diF5rMP673SXGBd641Pm?=
 =?us-ascii?Q?6lkuMC4YQo8Up959Oo5Qu0H8p2OaLlv1yqoS8ep1fW25cXoj0aIuwBZ2eL0L?=
 =?us-ascii?Q?RW9x6okjBJhymLKYzV6Rl/Y7Zx3JfTDbQZIU8G/DRvMGQ0kjoecushCkjIQY?=
 =?us-ascii?Q?tvnMXlCsH5xMu5rVI7u6FlYXRJESfjL9kU5o2y66srDLnQ9/rg2+WOLmLiWY?=
 =?us-ascii?Q?cBoTBuRCrhdJDcr5LbKR10CACL5J2Y9dPV9g3nSzcLeZHmhEkqAE2tou3TDr?=
 =?us-ascii?Q?kgKujzuj06ypyapxoEt7FGueJFBuoMb/q/GfRakilzLsQ/AgqtED2kS7QW7A?=
 =?us-ascii?Q?RMEJrG6yWeUSa9/wpiWgVeBvbPtaWwF9KBp+cyxqjV7NFL6OSvxImdRX5i8s?=
 =?us-ascii?Q?Rea7ZCFdpuc1yVJZoBwQq1BMKqZJpR5t4nCcesRy0c2W6xeRhD0ziXfMU6dD?=
 =?us-ascii?Q?TdDk+dpERW0/vSgNv9rXl8AGfl84nDByeRoP4LJIYSfrCaJgqJJZJyjHODSl?=
 =?us-ascii?Q?l8GKZQryPUrrXMil4NywXM5HI/4R0EiOrGvXi5/VnocFcA99BX3JfkadE35J?=
 =?us-ascii?Q?nNkGU4yT3JH2J9Q77D6Rq1uRjIumE9sdeK7ECNhejoZxb6giuc8Oafx9MP7H?=
 =?us-ascii?Q?e/sltrCJwACa5oacsvkUQiNlxoJRTu62WmQmUXrrY5NjPn1bNvsnww2O7dAo?=
 =?us-ascii?Q?dvCiSyXQs+HeBMoU37aECZsI2Ikk0OzHeLVJ+lcoWKNxnt4HBOJnZZZ0839E?=
 =?us-ascii?Q?yyxMvIruTAIcKintYwcktJGZYM59vQJpx8pBhJb+tuRxSzTGtofg2PM/fc2e?=
 =?us-ascii?Q?CMD2CC6kK8IQuJIqh5IfKgLVR4gWHJrvPV+63PK3NF0wo/B36WqFdSyCMApG?=
 =?us-ascii?Q?3qOY1aZkprD15QOZef/FNYzCRsdXJ4f6ZGvhm7lhoV3W9dIpLE1D77ZE+RMy?=
 =?us-ascii?Q?cJZMOlFsqA2Qv784f242ZplGwjv0kXKaemgbqkzWOHnz4wzhufPLy/PpagSJ?=
 =?us-ascii?Q?rgod6j/A1QSdnrfk0Tr+TGB+4ZlQSyEeX39O9vxgBvS2QdSA/6gAvdL5wrxH?=
 =?us-ascii?Q?MTj0gOz4cBt+395u7QGZs8FkgLJVlMAapUDYnGVt4H1EnoTxVezdG9S00QMd?=
 =?us-ascii?Q?rTQUIEj7Yt6tHU2RC+75qQJ3EbqAUL5hQ8Rnc4/WIunOFb2JVuhj3QmjCJHA?=
 =?us-ascii?Q?OtNN1s021oNX4mjZbjZwLC2rN+fmGdOTI60SS/uurDd0v23xEOJ1/amle9Fp?=
 =?us-ascii?Q?7zKCvLshdSfzTfrT4GcMfRYLxDiffhNjtoObAXCeQyqmdtXCncucoe429XIc?=
 =?us-ascii?Q?X3qH0R1Vq1VrIpzsARu6JFgqH5T6GTFBCuKeqEMvxvXz3YkMHsynevwRxqLC?=
 =?us-ascii?Q?dgrGyqW/3p56RrTNNL76pBhyGnGmkSTkiKIP3+34yeMb3jOevL1xsfdh1fBQ?=
 =?us-ascii?Q?n5+S0y0ABNCIEZeo8oYtmKStCAsX6UGCGwWlbvKaP4P3VjGlWfgiMJnMCkwy?=
 =?us-ascii?Q?0ms0aJTpWYLBBV4E8Al1NSnQHkcwhGyaKBUcQiyKSVgFJkh1xUrb5CNlOpvZ?=
 =?us-ascii?Q?rGC9VfJZ3t1lSUHdlXesjgc/S4GH3Vcsj8oW024KkJdl79i7U/NRFsRGKLp6?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8a277c-e0a6-451d-35b8-08dd5d1ef7c0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:22:54.5548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJHwZ+79/CZJGmQyNnT9VS1s5sdR6n/Cm3qfbjvMei8pFD6lZw93bKSu6PJ0xih1VM/Q0uzyQMKnn19RsSPvhn764oglgD5Gmp/MhY8eA1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3778
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

From: Zerun Fu <zerun.fu@corigine.com>

In the previous firmware load command logic, the driver doesn't send
the PF ID to the BSP, so the BSP can't process the DMA address correctly,
and this will lead to DMA mapping errors in memory read/write operations
when using multiple PF firmware.

Fix this by sending the PF ID to the BSP for firmware load command.

Fixes: 74fd1a71cec1 ("net/nfp: support loading firmware for card without DDR")
Cc: chaoyong.he@corigine.com
Cc: stable@dpdk.org

Signed-off-by: Zerun Fu <zerun.fu@corigine.com>
Reviewed-by: Chaoyong He <chaoyong.he@corigine.com>
Reviewed-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Peng Zhang <peng.zhang@corigine.com>
---
 drivers/net/nfp/nfpcore/nfp6000_pcie.c |  8 ++++++++
 drivers/net/nfp/nfpcore/nfp6000_pcie.h |  2 ++
 drivers/net/nfp/nfpcore/nfp_cpp.h      |  2 ++
 drivers/net/nfp/nfpcore/nfp_cppcore.c  |  6 ++++++
 drivers/net/nfp/nfpcore/nfp_nsp.c      | 14 +++++++++++---
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/nfp/nfpcore/nfp6000_pcie.c b/drivers/net/nfp/nfpcore/nfp6000_pcie.c
index 4693577f4e..83b7116097 100644
--- a/drivers/net/nfp/nfpcore/nfp6000_pcie.c
+++ b/drivers/net/nfp/nfpcore/nfp6000_pcie.c
@@ -1033,3 +1033,11 @@ nfp_cpp_from_nfp6000_pcie(struct rte_pci_device *pci_dev,
 
 	return cpp;
 }
+
+uint8_t
+nfp_get_pf_id_from_device(void *priv)
+{
+	struct nfp_pcie_user *nfp = priv;
+
+	return nfp->pci_dev->addr.function;
+}
diff --git a/drivers/net/nfp/nfpcore/nfp6000_pcie.h b/drivers/net/nfp/nfpcore/nfp6000_pcie.h
index 59b58ddd04..0d2e5bae0d 100644
--- a/drivers/net/nfp/nfpcore/nfp6000_pcie.h
+++ b/drivers/net/nfp/nfpcore/nfp6000_pcie.h
@@ -17,4 +17,6 @@ struct nfp_cpp *nfp_cpp_from_nfp6000_pcie(struct rte_pci_device *pci_dev,
 		const struct nfp_dev_info *dev_info,
 		bool driver_lock_needed);
 
+uint8_t nfp_get_pf_id_from_device(void *priv);
+
 #endif /* __NFP6000_PCIE_H__ */
diff --git a/drivers/net/nfp/nfpcore/nfp_cpp.h b/drivers/net/nfp/nfpcore/nfp_cpp.h
index 2defc4fa16..13d0c5fb68 100644
--- a/drivers/net/nfp/nfpcore/nfp_cpp.h
+++ b/drivers/net/nfp/nfpcore/nfp_cpp.h
@@ -384,4 +384,6 @@ int nfp_cpp_writeq(struct nfp_cpp *cpp, uint32_t cpp_id,
 
 uint32_t nfp_cpp_mu_locality_lsb(struct nfp_cpp *cpp);
 
+uint8_t nfp_get_pf_id_from_cpp(struct nfp_cpp *cpp);
+
 #endif /* __NFP_CPP_H__ */
diff --git a/drivers/net/nfp/nfpcore/nfp_cppcore.c b/drivers/net/nfp/nfpcore/nfp_cppcore.c
index dfc6d4613a..9f6417b7bf 100644
--- a/drivers/net/nfp/nfpcore/nfp_cppcore.c
+++ b/drivers/net/nfp/nfpcore/nfp_cppcore.c
@@ -1170,3 +1170,9 @@ nfp_cpp_map_area(struct nfp_cpp *cpp,
 err_eio:
 	return NULL;
 }
+
+uint8_t
+nfp_get_pf_id_from_cpp(struct nfp_cpp *cpp)
+{
+	return nfp_get_pf_id_from_device(nfp_cpp_priv(cpp));
+}
diff --git a/drivers/net/nfp/nfpcore/nfp_nsp.c b/drivers/net/nfp/nfpcore/nfp_nsp.c
index 732fa5802c..43c13baabe 100644
--- a/drivers/net/nfp/nfpcore/nfp_nsp.c
+++ b/drivers/net/nfp/nfpcore/nfp_nsp.c
@@ -24,6 +24,7 @@
 #define   NSP_COMMAND_OPTION    GENMASK_ULL(63, 32)
 #define   NSP_COMMAND_VER_MAJOR GENMASK_ULL(31, 28)
 #define   NSP_COMMAND_CODE      GENMASK_ULL(27, 16)
+#define   NSP_COMMAND_PF_ID     GENMASK_ULL(3, 2)
 #define   NSP_COMMAND_DMA_BUF   RTE_BIT64(1)
 #define   NSP_COMMAND_START     RTE_BIT64(0)
 
@@ -364,6 +365,7 @@ nfp_nsp_command_real(struct nfp_nsp *state,
 {
 	int err;
 	uint64_t reg;
+	uint64_t address;
 	uint32_t nsp_cpp;
 	uint64_t ret_val;
 	uint64_t nsp_base;
@@ -390,12 +392,18 @@ nfp_nsp_command_real(struct nfp_nsp *state,
 		return err;
 	}
 
-	err = nfp_cpp_writeq(cpp, nsp_cpp, nsp_command,
-			FIELD_PREP(NSP_COMMAND_OPTION, arg->option) |
+	address = FIELD_PREP(NSP_COMMAND_OPTION, arg->option) |
 			FIELD_PREP(NSP_COMMAND_VER_MAJOR, state->ver.major) |
 			FIELD_PREP(NSP_COMMAND_CODE, arg->code) |
 			FIELD_PREP(NSP_COMMAND_DMA_BUF, arg->dma) |
-			FIELD_PREP(NSP_COMMAND_START, 1));
+			FIELD_PREP(NSP_COMMAND_START, 1);
+
+	if (arg->code == SPCODE_FW_LOAD) {
+		address |= FIELD_PREP(NSP_COMMAND_PF_ID,
+				nfp_get_pf_id_from_cpp(cpp));
+	}
+
+	err = nfp_cpp_writeq(cpp, nsp_cpp, nsp_command, address);
 	if (err < 0) {
 		PMD_DRV_LOG(ERR, "CPP write command failed. err %d", err);
 		return err;
-- 
2.43.5

