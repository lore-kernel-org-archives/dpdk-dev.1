Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50888D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Dec 2025 15:56:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 044DF4060F;
	Mon,  8 Dec 2025 16:56:41 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021097.outbound.protection.outlook.com
 [40.107.130.97]) by mails.dpdk.org (Postfix) with ESMTP id 6F95040395
 for <dev@dpdk.org>; Mon,  8 Dec 2025 16:56:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKMLHAcP9Mek2DBmR7QvfODA4SR9vNQiriffVB8S6Qk8G0t/YmXcpNg+ASpSo+rXivjzaSH8lDcB0SvKrspy1jq8JoYfwAhs7XhIJ04YCQ8LWUSsQomwIpowsgL5u8X7RbKliL/uxLhsPccjZnpg0C+NbNsHMVMjUF/mdo/CgZVNvg/J7Ze8lT+hmLzgb44MwWWdH58uVT3SKrDgIdu/u6qZlaZ+OdtKwgkvLc9EOX3xFNCBV4IXc8zEDzCRoEyr0eN4+Mqecqg+zwArFOes9PV13NkVAJtDlp+PfL1pa2AwtxaZwWmuP69OVJuDt/L3GiaIkDT7FX+xNgt0zJDOUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5HRotHI+yU4Kgk7imfNZsWftz2IZ0Ld9Ouwr/4WZ50=;
 b=FpO371voI1tMwvU+tUCko5mhuif62nymlwe93NnrBfBKybhTi6vUatjvuMbTm+If7I2L7aV2CMH7XsYpcxBIwSbiZhXsMRc5b2tHZEaiu8xLPTyTnOJ+CWM5WX4RFAP0FiqbsnVMp3gQUSz1I/PS61fbO5mQ+c1Ze+2gUttgAeDEW2bUbA3lIjwTjgrHQhKMq9T3Nb6+4zjK4/MBm6XHFfPP39Fn7MxfDaJT0fY4fsJ0DCmyWV5J729nJfJqftrVxpjPha+2HSaJcRPWO6BlhRWZ1N2ogcdG7XQArItNu0d2bBdNGbcYMwJ2R3mq1kH+opfoTshX69qwNAM+4+VEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=catonetworks.com; dmarc=pass action=none
 header.from=catonetworks.com; dkim=pass header.d=catonetworks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catonetworks.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5HRotHI+yU4Kgk7imfNZsWftz2IZ0Ld9Ouwr/4WZ50=;
 b=Yv9udel81fnwIoJQ2PXxi59YrOHfKHM4CyuCftFd98B5ZCpurYfxaIZWrjeqU7lWSRIg/0EYZAhBtg5qcX9QwANeUmaHSFK7rEUo9XJvZjmwLp6neEoyPp9LmMwGiB2nZk8alLyND4rEsf2y8AymVleW8spvXqyV6cZ/x0knjx4=
Received: from VI1PR03MB4144.eurprd03.prod.outlook.com (2603:10a6:803:6b::14)
 by DU5PR03MB10219.eurprd03.prod.outlook.com (2603:10a6:10:51b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:56:37 +0000
Received: from VI1PR03MB4144.eurprd03.prod.outlook.com
 ([fe80::df15:73f4:64c2:b044]) by VI1PR03MB4144.eurprd03.prod.outlook.com
 ([fe80::df15:73f4:64c2:b044%2]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 15:56:37 +0000
From: Yan Yanovsky <yan.yanovsky@catonetworks.com>
To: "dev@dpdk.org" <dev@dpdk.org>, "qi.z.zhang@intel.com"
 <qi.z.zhang@intel.com>
CC: "ciara.loftus@intel.com" <ciara.loftus@intel.com>
Subject: Subject: [PATCH v3] af_xdp kick_tx() Retries instead of endless loop
Thread-Topic: Subject: [PATCH v3] af_xdp kick_tx() Retries instead of endless
 loop
Thread-Index: AQHcaFra70D/y13jfECEVpdJEQPVWQ==
Date: Mon, 8 Dec 2025 15:56:37 +0000
Message-ID: <VI1PR03MB4144B177CE39B84E0DE3F01FF7A2A@VI1PR03MB4144.eurprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=catonetworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB4144:EE_|DU5PR03MB10219:EE_
x-ms-office365-filtering-correlation-id: d9df3065-96bc-4e96-cb7d-08de36725e98
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?vtqaiA98qRlPl7YjQ7Y6+5FH1o9wXE3Vq7srgtTGU2c+s00VmNs2C1Nw1S?=
 =?iso-8859-1?Q?kmNT0QCSJRDusu5QFK1bwFF8CsSQ1BMxQzBYiBmeB+6Vf/Od902U4iZZUI?=
 =?iso-8859-1?Q?f20M7CBHiNUetXAq9MD8mfsL+0Ze+mIxQ+plIaoiY0kjFhZ0sVLeCDXeFL?=
 =?iso-8859-1?Q?GdZaXUWBqORPsnvIkQib5Pi2w4fecZuy7rRuVtL6R8koSpy0rqZaUKhcuC?=
 =?iso-8859-1?Q?++sF+DQWIlYkUOfB33LCO5Mec5ggvHhWI3o9z54BwxMu3Y6o3KN7wSyaCz?=
 =?iso-8859-1?Q?sBzhNrYgQbMlKN2Tudhrz9zgQuVOu/k9pdJ2LiL5j4qqpi2KbjqfsQEwbp?=
 =?iso-8859-1?Q?Po6qqyQg4a6yiQZcJMfG5LGhYa9lwyW5T9FwASPwZ14y0l7Hy6iMEzcFCz?=
 =?iso-8859-1?Q?2o3xOi4+SjxrUI1OQRjmI0iuzjWlVezVSRhKLSiwhpU20eOnj8l4cXXcmN?=
 =?iso-8859-1?Q?j8JU+MYzZe1hoxFUqKNRadehaILVmRgEWXQ3g6w1kkQxsp7KIboZI3nHTt?=
 =?iso-8859-1?Q?lf5NXHbhdd5JTEkbN6flqz8O35nx3wR1Out+AmdjDv74UpoO65B/wVTJJy?=
 =?iso-8859-1?Q?iUDC7jJ/LbDmuCRjLCyOpq32D3LC99tBtJeBs2NFcea8GUO8+NGA5VEjjo?=
 =?iso-8859-1?Q?//3z33tAnATHnLIlZw2GI8E8qOiPSdH7RLZJt5CWu4p2zpEzvJYPBbRZNw?=
 =?iso-8859-1?Q?H3p83xxJvvy5Obm9y2m9EqcT7ZegmK75WOYg5GmvDWVQ/ZiHYEHh2axODD?=
 =?iso-8859-1?Q?82BOpwR3a81ZYF3jU7YK+c7j0A4CbgF2tvHt0FGAWkI2vgRvnaIRgjpss1?=
 =?iso-8859-1?Q?Cp3GHt6dL8Edw3u8jkFBbcJVsCeXPYHX7LMojxtBvgOxamcRqGxCdupH2w?=
 =?iso-8859-1?Q?jXYZbPtt+XRfElcc9TsHwELIPS2BLldAmrK1/X07EscjE1lNI8VGoUtOgH?=
 =?iso-8859-1?Q?hlApNNpQ1T0R1l2xaU792fSv2ZujzPGyRcglo9saTkbVjuu3zut15sml9z?=
 =?iso-8859-1?Q?7I+d1jkoMGZX+cF/JQb8agymHbJOII8XEskiNIrJFPaWkxQhB+H2EpgIkT?=
 =?iso-8859-1?Q?QEpNtaV5WWYf8+VJRz+W3bqvPxLcLd4XmZIKwfnLVhOiXmZwd6TAfHcYpy?=
 =?iso-8859-1?Q?/zn0coKYY7IyHOu8aT+t0B7x3HWBWyyZ5cZOLjgKY1aIhPRNKz8U1zInA4?=
 =?iso-8859-1?Q?uoGXVPtKvJDe1tpT0yMGv+DcyOu3Dnmv3gCrJ/yMoRS1kNNJBXm7+GK3Ni?=
 =?iso-8859-1?Q?aQvcJC8CJNS8SXMyNTbjjwOgdMGCmQdI+FnvX05LgFf+6jsXVsqQPsom1k?=
 =?iso-8859-1?Q?r0ENZutzWLeToPx62EJLOyuKVLqjzp9uHtLH9ZxmDrIueFsQQ1h3OHOHnm?=
 =?iso-8859-1?Q?PIO57hAVKd/aqaXpysPO2yrQGZWi3xa83T4+rSPVAOlmaIZfzgHt4MXMUc?=
 =?iso-8859-1?Q?U7C3vlEFV0ky5Cs7vElfNTHYRrbahWnYCc9WfKo7t9TdbTzH0VGBXkhBb1?=
 =?iso-8859-1?Q?zIGJxBMjIbwz3kGT6HqERzpT6FBWnT3YWnU9uSjw6ANek7HQj8qe/GKKsN?=
 =?iso-8859-1?Q?TVSCFhpR7Rh+bKCPr4oBEbnX+XTv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB4144.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EaDSZgy5CPAj3bv58cZO0ldzPvhmY6jsG1vHQDzj1VkkqMbswxMvb0llVR?=
 =?iso-8859-1?Q?m3x3ed924zQxcYTpN8XoJ/m41nj/DFs69r3eODaEzUTBntFtwoD2ctGk1O?=
 =?iso-8859-1?Q?z1RPke8tl+jCtZwVqT7vApxzFsLwza46QgwN8CUbpHZtUU67/UbuNkR4/Y?=
 =?iso-8859-1?Q?PfLyh9LwBPcJWLHL/RxM52xmtD9Srydi2RZOH0pI4Dnlm1EEymjsB+FSvm?=
 =?iso-8859-1?Q?X6BFU5jefTM2nuH0q+KPmZPWyqIw1ACSKGYFRgq2KROLqOGwPv7Q88DN3Q?=
 =?iso-8859-1?Q?tX2+oLY+wqzsd2W2EGDo+ZJNOlsyQbz10D1BGcOGIIG/QSSr9IKES7YsrP?=
 =?iso-8859-1?Q?VnFMOBNIa8lnClPunqwLX858Ttsx0hdrJoCCXfqYr6fdft1Kw+ZuJab8B7?=
 =?iso-8859-1?Q?5QfbVIHRMmRHhmFHktxEzPABhY2g7XcYReB09ZU3v64tv1KsnwEXjd3n4d?=
 =?iso-8859-1?Q?HCcF0Uc8Dr0W0M1LLuz97rZZe/eRa2miEkutZvy8hbUWGs7MjAjRR6x49M?=
 =?iso-8859-1?Q?PJHwF8ehCsIXcS08FivVzl/Wr+gydyI7pWjTH1sJHxJEoAtfo71y3LqXXs?=
 =?iso-8859-1?Q?OeCN0eN3b0xFxLPq5FFSlrq0QYUCb9YuuCNqDasH6PqVW/kgoGeXlcPxxx?=
 =?iso-8859-1?Q?NC8CFuMV5dD3FSQxsyBTSbIZXnT3U4kxNb8Sg5TnSZKaMtrV4Gddo09g3u?=
 =?iso-8859-1?Q?WC4rYcrY/+PDZWo5Nimb3w7sa9gY1bhWtEisNMWOnnAnKkT/s7qJI9gj9m?=
 =?iso-8859-1?Q?jbIASIisH4xd6GD+gJnoYY0ZVzUHqFk22xt9ObicMPrtleTlZA+gdEwTCZ?=
 =?iso-8859-1?Q?pGLDgpn9/EciVYZ/wt6MAyju7ot7pRh5+6e2mnskjU1lSVCP1oK73ivgWA?=
 =?iso-8859-1?Q?/yt1DMsbNWDKvZ2fvrOsoeLe6CU5rPCSCTdBKDpj9Rg54g9LJoV+XpQ3cC?=
 =?iso-8859-1?Q?sUaV8FyoKiyvvp8MtVo7ZXF2cXMPouxVOeQzWWALkZvGA9ac0vn0sTTCLX?=
 =?iso-8859-1?Q?CuxPvMrFUwkRQzwjYSNEgmMsHImxttAuqJZ9i0mu/F8Omyx+SWjJa6lss5?=
 =?iso-8859-1?Q?zKor8K+mxdYTNPFVOLoU2WGRrtsPoq6aZzxSQKKBs3fTzQnZxIxkc3fqiq?=
 =?iso-8859-1?Q?DzA5TFslB/l2r3CS6uB2ZqcehSrJY8JCihXZ4eByTYcTXIgJsByt/3TDR7?=
 =?iso-8859-1?Q?T9MCSl5aeD+JzttUyzgaapxG3pJT99K/hE1KlayzgdW23cdwJp2lmwzBpW?=
 =?iso-8859-1?Q?Gu+yayBfgowSP/nOwpp39NE0F0YWsYJxauIPpkaE1DRsBnHtALtLG5He76?=
 =?iso-8859-1?Q?oxXcC9j2T5TlNiAbd6StHiJIGzDcrcG9ZKTqtn4eaYHRUwesEqKyeZ+cEM?=
 =?iso-8859-1?Q?NEPQE+JfGnZEjnXXoSu/NE2dkRBcrr5GF2llH6PNrrDf7EWIEyVTp5U9+Y?=
 =?iso-8859-1?Q?LgfG41+ja+BwrAEqASEvHfKTTN5Muqr8BXauikppPRSy9vj9Hnf61Xeasc?=
 =?iso-8859-1?Q?GkrBgVN2N5K3rZw+MQ24V+iWb3SaSFMzVkFWxMt5ERnHqJrRUaLAvUOM9o?=
 =?iso-8859-1?Q?T+hkv+qFFJH9goBvN3qK4qtKUMlTsHMGAo7VoXSHjc2TPyjHoTfaxr4cIU?=
 =?iso-8859-1?Q?laebVPPPKMdooUuJo2XCc74dWbL7xrP27smTPj84nmTi2jtrkrwPQOyw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: catonetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB4144.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9df3065-96bc-4e96-cb7d-08de36725e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 15:56:37.3943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d03fe63f-ee56-4020-a121-dd5b65bc7ea3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJ+4w0vLukxj3g2TZ6Z9sTX/L9CxWtyDS7Q2EXGNNMud6thtngeIbg0OoP2uwO7SejOTua6UevQutVyPuO0VMTh4xpP2IXQ1gFShK1R0Xfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10219
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

From 191d90eaab50c6855ee746361e7e735572f3b1ce Mon Sep 17 00:00:00 2001=0A=
From: Yan Yanovsky <yan.yanovsky@catonetworks.com>=0A=
Date: Sun, 7 Dec 2025 18:10:45 +0200=0A=
Subject: [PATCH v3] af_xdp kick_tx() Retries instead of endless loop=0A=
 Signed-off-by: Yan Yanovsky <yan.yanovsky@catonetworks.com>=0A=
=0A=
---=0A=
 drivers/net/af_xdp/rte_eth_af_xdp.c | 28 ++++++++++++++++++----------=0A=
 1 file changed, 18 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_e=
th_af_xdp.c=0A=
index b6ec9bf490..dc34f1a29e 100644=0A=
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c=0A=
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c=0A=
@@ -80,6 +80,7 @@ RTE_LOG_REGISTER_DEFAULT(af_xdp_logtype, NOTICE);=0A=
 #define ETH_AF_XDP_ETH_OVERHEAD		(RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)=
=0A=
 =0A=
 #define ETH_AF_XDP_MP_KEY "afxdp_mp_send_fds"=0A=
+#define MAX_TX_KICK_TRIES	10=0A=
 =0A=
 static int afxdp_dev_count;=0A=
 =0A=
@@ -480,22 +481,29 @@ static void=0A=
 kick_tx(struct pkt_tx_queue *txq, struct xsk_ring_cons *cq)=0A=
 {=0A=
 	struct xsk_umem_info *umem =3D txq->umem;=0A=
+	int tries =3D 0;=0A=
 =0A=
+	/* Pull completion queue entries to free UMEM buffers */=0A=
 	pull_umem_cq(umem, XSK_RING_CONS__DEFAULT_NUM_DESCS, cq);=0A=
 =0A=
-	if (tx_syscall_needed(&txq->tx))=0A=
-		while (send(xsk_socket__fd(txq->pair->xsk), NULL,=0A=
-			    0, MSG_DONTWAIT) < 0) {=0A=
-			/* some thing unexpected */=0A=
-			if (errno !=3D EBUSY && errno !=3D EAGAIN && errno !=3D EINTR)=0A=
-				break;=0A=
+	if (!tx_syscall_needed(&txq->tx))=0A=
+		return;=0A=
 =0A=
-			/* pull from completion queue to leave more space */=0A=
-			if (errno =3D=3D EAGAIN)=0A=
+	for (tries =3D 0; tries < MAX_TX_KICK_TRIES; tries++) {=0A=
+		if (send(xsk_socket__fd(txq->pair->xsk), NULL, 0,=0A=
+				MSG_DONTWAIT) >=3D 0)=0A=
+			break;=0A=
+		if (errno !=3D EBUSY && errno !=3D EAGAIN && errno !=3D EINTR)=0A=
+			break;=0A=
+=0A=
+		if (errno =3D=3D EAGAIN) {=0A=
+			/* Kernel TX ring has no space or UMEM completion queue=0A=
+			*  is lagging behind. Try pulling CQ to free room. */\=0A=
 				pull_umem_cq(umem,=0A=
-					     XSK_RING_CONS__DEFAULT_NUM_DESCS,=0A=
-					     cq);=0A=
+						XSK_RING_CONS__DEFAULT_NUM_DESCS, =0A=
+						cq);=0A=
 		}=0A=
+	}=0A=
 }=0A=
 =0A=
 #if defined(XDP_UMEM_UNALIGNED_CHUNK_FLAG)=0A=
-- =0A=
2.39.5=0A=
=0A=
