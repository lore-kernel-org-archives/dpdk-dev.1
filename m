Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15A9CCF9E5
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 13:00:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 854124028B;
	Mon, 27 Oct 2025 14:00:13 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id B8FE64026F
 for <dev@dpdk.org>; Mon, 27 Oct 2025 14:00:12 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021079.outbound.protection.outlook.com
 [40.107.130.79]) by mx-outbound21-216.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Oct 2025 13:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7uzkZ9CM8raLHHvHz6B3kpnjXme2/NBWYXhMQ27byzcJzTdcZMgyFDCwVVzl0WBIpDwcdkfd7qC2AYvvZf2aHju21BDPSGlhi+vsYNpf9uhTLfCRPm1J6Y+ni1k0X9pdlSSN6MIyAEUd35bakCcRHgOJcvH7t2wEg+Vv34v1du6C04LY9UyZR0dXljbWZwdEaJHcCZ4jtjcT8wJVIQ+Lu6cNEeeuL5QC5U/5LkvWiUqNrUyEtyFSFUmKP3Z3JDGZo4njZQGH9R/nBpwiTxABSP2pnx2ezOhSDjhXT2o3vXlls8nSfaIiXQkqSlzecIEkv5sZUOB4JCDVXpThZoxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tzy4XbJ1H2r3qowgfXa/uYcYVE/5g8sw5oZ5utqVx64=;
 b=kerbPxoSiCUap+vMXb/AIStNRud6mnh9N49Lp0oFo33SrJMgrXEGHR6yWtqy0MVDeYNN4Tze8IWIMpvoG4Nf480t4+mriXIPuIcx0keVEIpvShfiQwIyPVvCWBfpldXPoCnR1tuL6EO8+L1r0AzG1I4uVUMHXs88/5V9hyMekHCG0rh8iu2ow2eon7seGr+b9VXo4O39lRHr8kH+lckOxoD2gO83y+pFw5C3JN6KyX3Qbip89firIFO60HtCdi/dT7HePUIWdTZ99YUNqT+zqcIqlD1HC2nRc/mf31Zv0ZCwkt8nE1RMmWdDzXMaPb5pQOcOnFpaHpisTxvzTzP1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tzy4XbJ1H2r3qowgfXa/uYcYVE/5g8sw5oZ5utqVx64=;
 b=H66rxoasOHUdphswm1Ad8j7YsWuWbIB/gPryCSPMKYYXBQbayR2lOk4FvmgCsL6eUrZQsLuC7kMPaQMRWpC+KGcO0bfCaPmLdYILIsRQ26cX89RYJmiG9a0GoZzHK2RME7q4u3+MAQVv5s8WrXBKyTwtN0nfkwVwHDdxtwBKz7I=
Received: from AS4P250CA0023.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::11)
 by AM7P190MB0726.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:11f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Mon, 27 Oct
 2025 13:00:07 +0000
Received: from AM1PEPF000252DE.eurprd07.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::ab) by AS4P250CA0023.outlook.office365.com
 (2603:10a6:20b:5e3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Mon,
 27 Oct 2025 13:00:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM1PEPF000252DE.mail.protection.outlook.com (10.167.16.56) with Microsoft
 SMTP Server id 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025
 13:00:06 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org,
	thomas@monjalon.net
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v3 0/1] Clean up the guide for NTNIC PMD
Date: Mon, 27 Oct 2025 14:00:00 +0100
Message-ID: <20251027130002.597552-1-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <2974305.OYXXYNVTWy@thomas>
References: <2974305.OYXXYNVTWy@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DE:EE_|AM7P190MB0726:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fe67d3de-4bb6-4745-b70d-08de1558c0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KkEr161DqEQK8FoTzS8uIoP9F308pzSnWnEBeJaF8wJToEyE8x5u2Wxsg46q?=
 =?us-ascii?Q?DRzEuSipyN6sHtiTjVzuWX8OGkNWo05ERI8OYHtYAYN9/edEp1ERlke5dh0p?=
 =?us-ascii?Q?bGnJUWk0LR26cD7iAZDowY1lFk5xHthCI8+RoX/knRXk1nd5lj6fTZDULcdK?=
 =?us-ascii?Q?EHH363bDIwSyoNpg2N5/MpMt1ZmoJhbjT+c7lyKe6fyj1cZF8tCuYLVHCCcK?=
 =?us-ascii?Q?jX1VcMH6xPSyIxINewK+taX7eZA+tSC0gQ40bby53PZRw+BhoQtwXgAIla3a?=
 =?us-ascii?Q?A8A2gfmfVNb7Fcs17jEeG9jHlQ77d3UImf+egyTx+itA6iPA2tTnEHViON7P?=
 =?us-ascii?Q?5rJRgtqjSG99ZCE6c3TkdSWeax+wdxltc6bgPlvBtGf4GyScYOKWwkusOFoU?=
 =?us-ascii?Q?AW0axyEolYhZ474ON0b0cMGtZeshMhywQNinkiENS3EzVa7mgkkWbraOVek6?=
 =?us-ascii?Q?uG8G9YKLezy0TRETTbGTk3KG4kDywPPye6adxSi9NQK/yePt2aezlZ8iPmby?=
 =?us-ascii?Q?wGY5sTSA7p+Bmb8SXu4YIbmq5fHqzvWHfgO5FASVvktPJOiWP9epGcp+1ww9?=
 =?us-ascii?Q?ZmCQmkqiU/6Gf5R0rbzT8kFd7xeuN41GyCJRNSqHN57WxaoNqsgjjsHKvnzY?=
 =?us-ascii?Q?3qBJ5VjKrWmiOCmYgSxLbuCmxw84R9kf01uhJR8hA3RF2SBGcdYHaJuhYCmn?=
 =?us-ascii?Q?Wa+DFM9hQIfKS9r/JYRc+9ks4Qvtovl9x8CTHT1rxvNEbHFYuY5rptQq3d1X?=
 =?us-ascii?Q?96UqPduRBbgHp0b2XUIkK6xJRMKQGeR1T56dM1nkNN2kHPzgwsjg9h6XLYcq?=
 =?us-ascii?Q?yb1AYFhDMJLFC8HCIA8lT8cn8ize9HzOkv29htbcKZZBL3cz8ruEwYOv0Ezz?=
 =?us-ascii?Q?hwk5I6N4N6rXdGUkTawJtovX6uJbbhwlxyYFDVK7fYJsXvmuQXzivuyAjWYj?=
 =?us-ascii?Q?5mFx64wlES7koQmdtBx906H0TaO/yAMilk3SfrnuK+sCll7E2cW9Da5SFcmp?=
 =?us-ascii?Q?iS9u6cvypM8o5SxXu6g84SbjYhY90cVT+cHoi9ShLfYS5kYCHVrOke6NaQX4?=
 =?us-ascii?Q?kih6slBZzuNGEpdtitAdkq1SycdhGJXz3GPF0UZVCEjXEBfNtwU4WM+tj0Wd?=
 =?us-ascii?Q?HXyldwJEG3iViS/RjZWc15j6ZmU0iik234nFbLDTyCKBuh0J4hw6apuLAgwo?=
 =?us-ascii?Q?E38q9YDXWYNQvtkatwr+ESpU/nSPas/UNSPVWBSUDYmUcC9GsmBndaUJ6tm4?=
 =?us-ascii?Q?MY+PFBnQh7kMzXa02LFQOAb8+ZU0INmlcH658jI+nVYonhP79byetfdFoqkW?=
 =?us-ascii?Q?gDgLrdpZal8fXewBoDchVY3br90E/ZkMM1x4DLphNSsbY0sthrN+/5j1CbxV?=
 =?us-ascii?Q?E++AOEoquoGNNrLQ7Lhg/u/cFP55MjZCYVklDLIGZZw8ofBXfBsbvq+78F6l?=
 =?us-ascii?Q?I8CSXTx0XN3fs8mnspLttSY0f06f642Ouop/oTmFwdp3mIn/emW4jZwxCqdE?=
 =?us-ascii?Q?UzCnhhb9ztqH4RKUmZ7RwFYdvqasZ301OsdkThupRHT1ZXQbHYGEIzP/YSkp?=
 =?us-ascii?Q?EIxGVpD0/0h3dN4Eyl0=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HOGXK6bGoEQ/XWolWabTxHWOAxtHsIOIuoHtlK2RZa9SyfJBStKvFkvkLQB/ywWw932wSxkp//zRnFTVvXCztM/d2ki4s8fDilgq1xIOBy28d6CCzwBhDN0qBcMPzdRhA5gJjy6Z1/nOo/yUtbktXwNGcgS8RkHV9/uo0HcZvqzks80D2v3EFc0lsw3ReGRrf9nrrJvvsR9MH0Z82txXuVk2c0OIqLFMyi502DozhFEBx/S5z9wveKDcFvRpr40PtrnQTQ+UmgFd5TNXBOZ8fjKtYOwKHlY52eka5nIvOA5uv++KXE9TybAxxGHaMrOdTJB2N+tBbg9EV9Vij1NSkqJtSyxo/vdUp5iJ+Sgii6B30iB/cGXPTv7B0tNlVVex2JsyW+RcOVcJVSGRkvB3k2vkwT7FBVpElt/5VDTqYk0WZh63DvOZPuMVfqrkK+N6k3GnVfrIWw/UpUQouc16ic9bxa30PsXAmM5oF5c8r4QdHoTJU3DGqKL2dMZs0ZHze2gYelvGIcg4/6cwb2ZtQVF4TjeImwysyviQn5jZin0E1AucxcXysre5ICPNokVPgJpgPMLh2GUloixxhu0edxAIFkZui51AwNd09AtIpX7XTIMwy4KddEGR+ZcqV5d3El5ZwBzHzKMQ98boXN47SrmD4BaCswBiBhqLZr+cv4A=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 13:00:06.5518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe67d3de-4bb6-4745-b70d-08de1558c0ab
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DE.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0726
X-BESS-ID: 1761570009-305592-7662-115926-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.130.79
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYGJkBGBlDMMNHS0jjRPC3N2M
 w02STZItUk2SDZ3MAyycwsxdDEME2pNhYAfapBLUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268512 [from 
 cloudscan22-174.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

Hi,

I have made the requested changes.
The simple list of features was converted into a list-table.

Serhii Iliushyk (1):
  doc: refactoring the guide for NTNIC PMD

 doc/guides/nics/ntnic.rst | 204 ++++++++++++++++++++------------------
 1 file changed, 106 insertions(+), 98 deletions(-)

-- 
2.45.0

