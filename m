Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C3DC7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Jun 2025 11:22:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 21D8E40A71;
	Wed, 25 Jun 2025 13:22:23 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 46AA640677
 for <dev@dpdk.org>; Wed, 25 Jun 2025 13:22:22 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAtin8004718
 for <dev@dpdk.org>; Wed, 25 Jun 2025 04:22:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=wR0bcX8wDZubDHyl+0tVxxf
 h5vKum2QWXqAr32fHhm8=; b=cPwJ0B5L4MEd86WgmYVCGH9oovh/KV+tjRsEor7
 qSC+zxgw8Mygh0Lsuxbx8hk4n+aPjDTTiW2wollGAPmmhol9Kp1uGP0RgQpMc04C
 tD0h6u7aEfLXlXqDj4gsNAqDw3yH/ii5Bn+0eRV2ti+NoSGwAml7bdeDXBRyIqVQ
 Ge/rahW2v1r3/MlngKdI1kyH8kIrnIGKPQN+gwE2lZKCs59l+Q06B3TO9LFfd3c9
 zBV/iRXTTXfvAxlGwKVrx1SDcVA4M+JKRE62ZKB9xkH/zruzPqKH1laOBiAptIxW
 ihTfZgECV0WKKPnUbq87CbBGYaeVwKFNpHeAeK2AY9uVTyQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47gfrf81mr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 25 Jun 2025 04:22:20 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 25 Jun 2025 04:22:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 25 Jun 2025 04:22:20 -0700
Received: from cavium-optiplex-3070-BM15.. (unknown [10.28.34.39])
 by maili.marvell.com (Postfix) with ESMTP id BE48A3F7059;
 Wed, 25 Jun 2025 04:22:18 -0700 (PDT)
From: Tomasz Duszynski <tduszynski@marvell.com>
To: <dev@dpdk.org>, Jakub Palider <jpalider@marvell.com>, Tomasz Duszynski
 <tduszynski@marvell.com>
Subject: [PATCH] raw/cnxk_gpio: fix out of bound access
Date: Wed, 25 Jun 2025 13:22:08 +0200
Message-ID: <20250625112209.2469589-1-tduszynski@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=avGyCTZV c=1 sm=1 tr=0 ts=685bdbec cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=Jf4Ctrm7hqK5CDuhlBAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: XYyD6S7KVdOs2sURlqHS84jBKx8XMxCY
X-Proofpoint-GUID: XYyD6S7KVdOs2sURlqHS84jBKx8XMxCY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NSBTYWx0ZWRfX84Z0Ye9tQubt
 k0MBQvumTHQJk+Y5t84XUrUc3KnQHf6E9nkhh6ruQWysPQcURXKlo/Kma97YPt1C+14Y79wsHN9
 VNM6cnf/jNY54pD9fP13G0oM9msER67Z+sfi1baJpoEdLKR9+DBPOq5ud6TBEFCyQ+njbmsXXxR
 RzG8cyPmc0u6C8rue0+bd/bIXtubk7H9P7TR4RfpSS0NzoX2XujKHC5Wj69nDYj23S4FsMg//1a
 VAuzRDWbIvOFewpS4GDaFMhh3QhDJRNjPdokVyf/ocVEdS9pzoKMHEH5HSfMwBOS5mczUEg8DFz
 HMGA3DZ7UrkeWAiuLlEqWFNVIu6gyv57FMParqWH/p860rPdAuYjqlNCSlFMzCiJkNGPcWGaf61
 yJZ1A9FX4oL6RdNmqk4xxaok8upaRNTdudeiRfj9AyJbhmTUdV9j9gy3y/hOCybHdgTwpbny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-23_07,2025-03-28_01
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

In rare circumstances such as when underlying gpio device is being
removed while userspace access is still ongoing flags returned from
ioctl() may be invalid.

Coverity issue: 469060
Coverity issue: 469061
Coverity issue: 469067
Coverity issue: 469068
Fixes: 9a5ce79325da ("raw/cnxk_gpio: switch to character-based GPIO interface")

Signed-off-by: Tomasz Duszynski <tduszynski@marvell.com>
---
 drivers/raw/cnxk_gpio/cnxk_gpio.c | 38 ++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio.c b/drivers/raw/cnxk_gpio/cnxk_gpio.c
index bb2dca5441..0549e326f9 100644
--- a/drivers/raw/cnxk_gpio/cnxk_gpio.c
+++ b/drivers/raw/cnxk_gpio/cnxk_gpio.c
@@ -513,7 +513,7 @@ static const struct {
 	{ CNXK_GPIO_PIN_EDGE_BOTH, GPIO_V2_LINE_FLAG_EDGE_FALLING | GPIO_V2_LINE_FLAG_EDGE_RISING },
 };
 
-static enum gpio_v2_line_flag
+static int
 cnxk_gpio_edge_to_flag(enum cnxk_gpio_pin_edge edge)
 {
 	unsigned int i;
@@ -522,11 +522,13 @@ cnxk_gpio_edge_to_flag(enum cnxk_gpio_pin_edge edge)
 		if (cnxk_gpio_edge_flag[i].edge == edge)
 			break;
 	}
+	if (i == RTE_DIM(cnxk_gpio_edge_flag))
+		return -EINVAL;
 
 	return cnxk_gpio_edge_flag[i].flag;
 }
 
-static enum cnxk_gpio_pin_edge
+static int
 cnxk_gpio_flag_to_edge(enum gpio_v2_line_flag flag)
 {
 	unsigned int i;
@@ -535,6 +537,8 @@ cnxk_gpio_flag_to_edge(enum gpio_v2_line_flag flag)
 		if ((cnxk_gpio_edge_flag[i].flag & flag) == cnxk_gpio_edge_flag[i].flag)
 			break;
 	}
+	if (i == RTE_DIM(cnxk_gpio_edge_flag))
+		return -EINVAL;
 
 	return cnxk_gpio_edge_flag[i].edge;
 }
@@ -549,7 +553,7 @@ static const struct {
 	{ CNXK_GPIO_PIN_DIR_LOW, GPIO_V2_LINE_FLAG_OUTPUT },
 };
 
-static enum gpio_v2_line_flag
+static int
 cnxk_gpio_dir_to_flag(enum cnxk_gpio_pin_dir dir)
 {
 	unsigned int i;
@@ -558,11 +562,13 @@ cnxk_gpio_dir_to_flag(enum cnxk_gpio_pin_dir dir)
 		if (cnxk_gpio_dir_flag[i].dir == dir)
 			break;
 	}
+	if (i == RTE_DIM(cnxk_gpio_dir_flag))
+		return -EINVAL;
 
 	return cnxk_gpio_dir_flag[i].flag;
 }
 
-static enum cnxk_gpio_pin_dir
+static int
 cnxk_gpio_flag_to_dir(enum gpio_v2_line_flag flag)
 {
 	unsigned int i;
@@ -571,6 +577,8 @@ cnxk_gpio_flag_to_dir(enum gpio_v2_line_flag flag)
 		if ((cnxk_gpio_dir_flag[i].flag & flag) == cnxk_gpio_dir_flag[i].flag)
 			break;
 	}
+	if (i == RTE_DIM(cnxk_gpio_dir_flag))
+		return -EINVAL;
 
 	return cnxk_gpio_dir_flag[i].dir;
 }
@@ -675,7 +683,10 @@ cnxk_gpio_process_buf(struct cnxk_gpio *gpio, struct rte_rawdev_buf *rbuf)
 	case CNXK_GPIO_MSG_TYPE_SET_PIN_EDGE:
 		edge = *(enum cnxk_gpio_pin_edge *)msg->data;
 		info.flags &= ~(GPIO_V2_LINE_FLAG_EDGE_RISING | GPIO_V2_LINE_FLAG_EDGE_FALLING);
-		info.flags |= cnxk_gpio_edge_to_flag(edge);
+		ret = cnxk_gpio_edge_to_flag(edge);
+		if (ret < 0)
+			break;
+		info.flags |= ret;
 
 		config.attrs[config.num_attrs].attr.id = GPIO_V2_LINE_ATTR_ID_FLAGS;
 		config.attrs[config.num_attrs].attr.flags = info.flags;
@@ -687,7 +698,10 @@ cnxk_gpio_process_buf(struct cnxk_gpio *gpio, struct rte_rawdev_buf *rbuf)
 	case CNXK_GPIO_MSG_TYPE_SET_PIN_DIR:
 		dir = *(enum cnxk_gpio_pin_dir *)msg->data;
 		config.attrs[config.num_attrs].attr.id = GPIO_V2_LINE_ATTR_ID_FLAGS;
-		config.attrs[config.num_attrs].attr.flags = cnxk_gpio_dir_to_flag(dir);
+		ret = cnxk_gpio_dir_to_flag(dir);
+		if (ret < 0)
+			break;
+		config.attrs[config.num_attrs].attr.flags = ret;
 		config.attrs[config.num_attrs].mask = RTE_BIT64(gpio->num);
 		config.num_attrs++;
 
@@ -727,18 +741,26 @@ cnxk_gpio_process_buf(struct cnxk_gpio *gpio, struct rte_rawdev_buf *rbuf)
 		*(int *)rsp = !!(values.bits & RTE_BIT64(gpio->num));
 		break;
 	case CNXK_GPIO_MSG_TYPE_GET_PIN_EDGE:
+		ret = cnxk_gpio_flag_to_edge(info.flags);
+		if (ret < 0)
+			return ret;
+
 		rsp = rte_zmalloc(NULL, sizeof(enum cnxk_gpio_pin_edge), 0);
 		if (!rsp)
 			return -ENOMEM;
 
-		*(enum cnxk_gpio_pin_edge *)rsp = cnxk_gpio_flag_to_edge(info.flags);
+		*(enum cnxk_gpio_pin_edge *)rsp = ret;
 		break;
 	case CNXK_GPIO_MSG_TYPE_GET_PIN_DIR:
+		ret = cnxk_gpio_flag_to_dir(info.flags);
+		if (ret < 0)
+			return ret;
+
 		rsp = rte_zmalloc(NULL, sizeof(enum cnxk_gpio_pin_edge), 0);
 		if (!rsp)
 			return -ENOMEM;
 
-		*(enum cnxk_gpio_pin_dir *)rsp = cnxk_gpio_flag_to_dir(info.flags);
+		*(enum cnxk_gpio_pin_dir *)rsp = ret;
 		break;
 	case CNXK_GPIO_MSG_TYPE_GET_PIN_ACTIVE_LOW:
 		rsp = rte_zmalloc(NULL, sizeof(int), 0);
-- 
2.34.1

