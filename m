Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294CBC5ACD9
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 17:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B05524064F;
	Fri, 20 Feb 2026 18:06:27 +0100 (CET)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3A80D402E3
 for <dev@dpdk.org>; Fri, 20 Feb 2026 18:06:23 +0100 (CET)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-503347e8715so26862231cf.2
 for <dev@dpdk.org>; Fri, 20 Feb 2026 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771607182;
 x=1772211982; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SezU/5GufF1EnMCX8wl/9cMSJxt7mlXFMHwW5iGBxLY=;
 b=2FxSjVyMmWgJGHuN3BPoh5fU3K2R8sTIcryfqivyQi3UbIHetCq9UamXjXtY5KA6Wd
 J9YispWn9qHysUUjtb/iBMsbBIN8vGV1FwF+z/ha3cJ0JNOYeObsdqqBOogvQRmEXVUz
 9EsCqgKeHJQK2II6mCqbynsWM0FeRLBqk4FSCJKwBvksnXX+YJ3J4dpomlPyY6Tx0siQ
 zfgXtOiBxCNwZycUc2qYkz6Lx33f5IMCC9vf3bMn8ED8qDjhsEpz+sj/L4ulHJz2kxOz
 ZyjBdi6e+RwuPM6O7s34IBf9S0g+biyh40y1HdUAwu2zs1UqM4b2vgukSLDltGWwn+3r
 1JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771607182; x=1772211982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SezU/5GufF1EnMCX8wl/9cMSJxt7mlXFMHwW5iGBxLY=;
 b=tFjSdTk8qCZLMrqA6V8mG7vwvdH9wr528KE445j2adyqRbRTlXBaODmXlwTMh/O4hS
 ZwlLQnNtPixvq51jiee6MsjYFVvosZsFl0kZB08zQXQf1yGtbqWO6kSnmpOVm4zKgZr6
 UnMLM8RkZoGol7YhXUg9vLQ5iSJT4YbCuDILwGgBpzZcM6MTGM4WJi6lx9cOK7vjMQ90
 nKz5snvQmoLJvvI6U6igagGkKqufte/wcvxLAJQpLnrRxMlpBOSIG5oFOewsNbs6wXoe
 +pwH9TDmeKtENgI2+tOoPi4WbDEiQkhK22al4JFZjgx2SXfMxoIwxj44D/J+AxRAx3ix
 CfUA==
X-Gm-Message-State: AOJu0YzdFEMzTyHXjH7ZxArD1oD+9cY2VPPNU9Gf+ddf0wmeiFEIZuJm
 UoaA2OISHe3/cGPOLf6qOQg6TLfAtB4Z7lhltnEHH5puoNCe2ku3XClVDKhamq2nGBfwx4EiXPt
 D3bOQ
X-Gm-Gg: AZuq6aKcuoVIVVKjD7VPt2O5K3jLtCkpXPsFhDkucVXmAfDi8w/PGiSexlIk3xlrVVN
 EMF6mpHG8IpwWKK/oEzVEXVtjm8b/xQMW+Fowzluq+R3ylPtFfNijkhfDcdXUplD9uwzw+63osU
 +vsmWqef/NTUmpH7ihou4igRfJXc7dDCm+MC4qX3uW9Ru502BWeV7w5S4uMnrevMUDya5uF+cST
 R+ADu32mabqYB9kvSHhOLDjAI4DCdopLsbqCpI8umUPSqEdR54/bpG75fOXIdm+XrA/2j7Rfa5G
 6Rhd+/uTQRP1cuPmfrZ0XiIvm5oascure9kS0kxVOXQaa7CpuUekVyxFQEanBx5h6vzNV0PhQgt
 6KgN/AaF+X8//5CVGuS+JP18BuGhzZOQRQ+HrmhXZR4A0hR0sr6XjBnD4JGF9TZ+T3X+KdEK83w
 xCu1jrc0dkQ+Yj/BO5LpJDY6zdyXuLbtaUgC4WGxLyAgm5i4AjV4sXFt+Ez+Y29w==
X-Received: by 2002:a05:622a:247:b0:4f1:e928:3fda with SMTP id
 d75a77b69052e-5070bbd9a58mr8170671cf.26.1771607182340; 
 Fri, 20 Feb 2026 09:06:22 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50684bc39e6sm276277591cf.31.2026.02.20.09.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 09:06:22 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 03/10] net/tap: extend fixed MAC range to 16 bits
Date: Fri, 20 Feb 2026 09:02:03 -0800
Message-ID: <20260220170614.75560-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170614.75560-1-stephen@networkplumber.org>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260220170614.75560-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The generated fixed MAC address stored the interface index in a single
byte, which wraps after 256 devices and produces duplicate MACs under
repeated hot-plug. Spread the index across the last two bytes of the
address, extending the unique range to 65536.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/tap/rte_eth_tap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index e06e1ca079..8b6d5db37e 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2274,13 +2274,15 @@ set_mac_type(const char *key __rte_unused,
 		return 0;
 
 	if (!strncasecmp(ETH_TAP_MAC_FIXED, value, strlen(ETH_TAP_MAC_FIXED))) {
-		static int iface_idx;
-
-		/* fixed mac = 02:64:74:61:70:<iface_idx> */
-		memcpy((char *)user_mac->addr_bytes, "\002dtap",
-			RTE_ETHER_ADDR_LEN);
-		user_mac->addr_bytes[RTE_ETHER_ADDR_LEN - 1] =
-			iface_idx++ + '0';
+		static uint16_t iface_idx;
+
+		/* fixed mac that is locally assigned based off of iface_idx. */
+		user_mac->addr_bytes[0] = RTE_ETHER_LOCAL_ADMIN_ADDR; /* 0x2 */
+		user_mac->addr_bytes[1] = 'd';
+		user_mac->addr_bytes[2] = 't';
+		user_mac->addr_bytes[3] = 'a';
+		user_mac->addr_bytes[4] = 'p' + (iface_idx >> 8);
+		user_mac->addr_bytes[5] = '0' + (uint8_t)iface_idx++;
 		goto success;
 	}
 
-- 
2.51.0

