Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860391094481
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Mar 2026 23:21:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 558D640280;
	Sun, 22 Mar 2026 00:21:04 +0100 (CET)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 5226D400D7
 for <dev@dpdk.org>; Sun, 22 Mar 2026 00:21:01 +0100 (CET)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so3467525eec.1
 for <dev@dpdk.org>; Sat, 21 Mar 2026 16:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774135260;
 x=1774740060; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYcvxJYdUCHbONmt65reyAveAVYExJL/YzxnayiYc1g=;
 b=nHkKA/60gD4y8otH9Mz41wqR5si23SB2S36M92jRHJpFtspIaNMVn9sp/ZH8J1CfHi
 wUkxQoIYnZz34BB/Q2KW7q2m/RA/AXdU2xRR8oqMUTIVJEiQuDBlKteLe8ez7NjRGpMx
 2SooMM/GD/TeX3swNGpAOMj10mGn1Ol4Vzh5xSaRZx25Sps/4LYEtBtx3pUgDgVTRH4J
 E6Ax8RQ3i2y91DAf1JkknsGy8szoI9uQntBymJFFHpq1hIayju9Y1Me/1WHq6E0HCHNW
 5oKrvvFfeusaAX2L8tjoKGmlYE5MH6B+8fhCUM4tzAKYVmUr/o/D0Ep2mkv3VfJkhi3y
 DOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774135260; x=1774740060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TYcvxJYdUCHbONmt65reyAveAVYExJL/YzxnayiYc1g=;
 b=S7NN2XKSxCr4vB57ZwjoaPm2aRmp2/qf5JP1FrJYQNcn/fo1cMW/gLGtpTsj+Gr2kU
 b2jb1vYMp90+B1UamwAiNndU6VVt188Ajw9/cmHcEODH3k9rVkvoOsyypwVENU48BxOD
 PwTFI/HqUh+h52A8KkGkLh9/4XHuFvKJ/c54Vo3GGsi/6IbYEumkjEn/dWQkFSbywtC/
 WnrgSmViK4LMFyBOuj0kMpciv588AOSpIadYk4uUYM0+WMKR2jt4BxelWhAFDgJSn+qm
 lC30eoQPpWTzjQDTXnmXf1f47D94CPBng0BS8hxHoIYlTV/obl561B4lqyNJUPCrzENc
 Zohw==
X-Gm-Message-State: AOJu0YxlrR2Ou+IKJp9C/9yFxv1+pTv10Nu9/n9yM4g/U87qqaYEltIp
 SZ/2y8La2bDH3i0r0rhaV2iimE+RrhyCU9sq3dj4aucDlJYvkTIt/tvtcm17Cf3hPL8Lfk0bnKN
 TWHJI
X-Gm-Gg: ATEYQzxv4et8Jz/I7fGcLxCiZi/bMth63CaR8ph4LsgehsrLWQiRn94HJxtfT5AZVCH
 ZcZ/gbmDCC1qZEfP8zl0cVntTXmC5tZwEWMVLkfRZSz6Uni4oM3xkCqPOIalnPTTa9iM20yOlLc
 2rVRoObGAs9SL8Fl3vK+7xy6lAiFj5Q3imE5EV+FEYAuKbQFIgZPgGbKPzjaSj4DSwa5a7omvl1
 xbYgRr8QmDkij8bChWb4SM6GkrziKHDN97VEXAl+iKR8kQnco1RYOQqTCM7CHj7VakXcTa/+X76
 3cvMyiEvV+WwpHalzvZWl7OS0zYeEq9mtGY16KP8NCKk1K6VkDUEUKHkD/FoTXW4SYns7DXlWRk
 nbYKJe3Up20O1m7/98bH1lupvMZuSfxc5rc7V2p8QnVDpjR268QVlc7cJVejg63vyhEU5JmZVkM
 AXZIiGae7s2HTKbj5tYSgRIretAirnRIQb0BU=
X-Received: by 2002:a05:693c:3106:b0:2b7:b7e7:9025 with SMTP id
 5a478bee46e88-2c10980a36dmr3417948eec.31.1774135260119; 
 Sat, 21 Mar 2026 16:21:00 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b2d01f7sm8124547eec.23.2026.03.21.16.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 16:20:59 -0700 (PDT)
Date: Sat, 21 Mar 2026 16:20:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH dpdk v3] net/tap: add software MAC address filtering
Message-ID: <20260321162057.09dbd5fc@phoenix.local>
In-Reply-To: <20260321144840.863746-2-rjarry@redhat.com>
References: <20260319221034.703656-2-rjarry@redhat.com>
 <20260321144840.863746-2-rjarry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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

On Sat, 21 Mar 2026 15:48:40 +0100
Robin Jarry <rjarry@redhat.com> wrote:

> Linux TAP devices deliver all packets to userspace regardless of the
> PROMISC/ALLMULTI flags on the interface. When promiscuous mode is
> disabled, drop received packets whose destination MAC does not match
> any configured unicast or multicast address.
>=20
> The receive path checks the destination MAC against the device's
> unicast address table (managed by the ethdev layer), the multicast
> address list (stored by the driver since the ethdev layer does not keep
> a copy), and accepts broadcast unconditionally. Promiscuous and
> all-multicast modes bypass the respective checks.
>=20
> To support multiple unicast addresses via rte_eth_dev_mac_addr_add(),
> allocate mac_addrs with rte_zmalloc (TAP_MAX_MAC_ADDRS=3D16) instead of
> pointing into dev_private, and advertise the new limit in dev_infos_get.
>=20
> Dropped packets are reported via per-queue xstats
> (rx_q<N>_mac_filter_drops).
>=20
> Signed-off-by: Robin Jarry <rjarry@redhat.com>
> ---

Here is a test for this.

=46rom f1f093323a713abdfeb36a486a16b4b816095953 Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sat, 21 Mar 2026 16:14:00 -0700
Subject: [PATCH 2/2] net/tap: add tests for software MAC address filtering

Extend the TAP PMD test suite to cover the new MAC filtering API.
Verify that dev_info advertises multiple unicast addresses,
mac_addr_add/remove and set_mc_addr_list work correctly,
and mac_filter_drops xstats are present and reset properly.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_tap.c | 133 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/app/test/test_pmd_tap.c b/app/test/test_pmd_tap.c
index dabd7d3506..bd3d4a64cc 100644
--- a/app/test/test_pmd_tap.c
+++ b/app/test/test_pmd_tap.c
@@ -757,6 +757,135 @@ test_tap_setup(void)
 	return 0;
 }
=20
+/*
+ * MAC address filtering tests.
+ *
+ * These exercise the new software MAC filtering paths added to TAP:
+ * mac_addr_add/remove, set_mc_addr_list, xstats for mac_filter_drops,
+ * and the increased max_mac_addrs reported in dev_info.
+ */
+
+static int
+test_tap_mac_filter_info(void)
+{
+	struct rte_eth_dev_info dev_info;
+
+	TEST_ASSERT_SUCCESS(rte_eth_dev_info_get(tap_port0, &dev_info),
+			    "failed to get dev info");
+	TEST_ASSERT(dev_info.max_mac_addrs >=3D 16,
+		    "max_mac_addrs=3D%u, expected >=3D 16",
+		    dev_info.max_mac_addrs);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_tap_mac_addr_ops(void)
+{
+	struct rte_ether_addr addr, addr2;
+
+	rte_eth_random_addr(addr.addr_bytes);
+	rte_eth_random_addr(addr2.addr_bytes);
+
+	TEST_ASSERT_SUCCESS(rte_eth_dev_mac_addr_add(tap_port0, &addr, 0),
+			    "mac_addr_add first address failed");
+	TEST_ASSERT_SUCCESS(rte_eth_dev_mac_addr_add(tap_port0, &addr2, 0),
+			    "mac_addr_add second address failed");
+
+	rte_eth_dev_mac_addr_remove(tap_port0, &addr2);
+	rte_eth_dev_mac_addr_remove(tap_port0, &addr);
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_tap_mc_addr_list(void)
+{
+	struct rte_ether_addr mc_addrs[3];
+	int i;
+
+	for (i =3D 0; i < 3; i++) {
+		rte_eth_random_addr(mc_addrs[i].addr_bytes);
+		mc_addrs[i].addr_bytes[0] |=3D RTE_ETHER_GROUP_ADDR;
+	}
+
+	TEST_ASSERT_SUCCESS(rte_eth_dev_set_mc_addr_list(tap_port0, mc_addrs, 3),
+			    "set_mc_addr_list(3) failed");
+	TEST_ASSERT_SUCCESS(rte_eth_dev_set_mc_addr_list(tap_port0, mc_addrs, 1),
+			    "set_mc_addr_list(1) failed");
+	TEST_ASSERT_SUCCESS(rte_eth_dev_set_mc_addr_list(tap_port0, NULL, 0),
+			    "set_mc_addr_list(0) failed");
+
+	return TEST_SUCCESS;
+}
+
+static int
+test_tap_xstats_mac_filter(void)
+{
+	struct rte_eth_xstat_name *names =3D NULL;
+	struct rte_eth_xstat *xstats =3D NULL;
+	int nb_xstats, ret, i;
+	int found =3D 0;
+	int result =3D TEST_FAILED;
+
+	nb_xstats =3D rte_eth_xstats_get_names(tap_port0, NULL, 0);
+	TEST_ASSERT(nb_xstats > 0,
+		    "expected at least 1 xstat, got %d", nb_xstats);
+
+	names =3D calloc(nb_xstats, sizeof(*names));
+	xstats =3D calloc(nb_xstats, sizeof(*xstats));
+	if (names =3D=3D NULL || xstats =3D=3D NULL) {
+		printf("Error: failed to allocate xstats arrays\n");
+		goto out;
+	}
+
+	ret =3D rte_eth_xstats_get_names(tap_port0, names, nb_xstats);
+	if (ret !=3D nb_xstats) {
+		printf("Error: xstats_get_names returned %d, expected %d\n",
+		       ret, nb_xstats);
+		goto out;
+	}
+
+	/* Verify at least one mac_filter_drops counter exists */
+	for (i =3D 0; i < nb_xstats; i++) {
+		if (strstr(names[i].name, "mac_filter_drops") !=3D NULL)
+			found++;
+	}
+	if (found =3D=3D 0) {
+		printf("Error: no mac_filter_drops xstat found\n");
+		goto out;
+	}
+
+	/* Reset and verify the mac_filter_drops counters are zero */
+	if (rte_eth_xstats_reset(tap_port0) !=3D 0) {
+		printf("Error: xstats_reset failed\n");
+		goto out;
+	}
+
+	ret =3D rte_eth_xstats_get(tap_port0, xstats, nb_xstats);
+	if (ret !=3D nb_xstats) {
+		printf("Error: xstats_get after reset returned %d\n", ret);
+		goto out;
+	}
+
+	for (i =3D 0; i < nb_xstats; i++) {
+		if (strstr(names[i].name, "mac_filter_drops") =3D=3D NULL)
+			continue;
+		if (xstats[i].value !=3D 0) {
+			printf("Error: %s not zero after reset\n",
+			       names[i].name);
+			goto out;
+		}
+	}
+
+	result =3D TEST_SUCCESS;
+
+out:
+	free(names);
+	free(xstats);
+	return result;
+}
+
 /* Individual test case wrappers */
=20
 static int
@@ -1128,6 +1257,10 @@ static struct unit_test_suite test_pmd_tap_suite =3D=
 {
 		TEST_CASE(test_tap_multiqueue),
 		TEST_CASE(test_tap_rx_queue_setup),
 		TEST_CASE(test_tap_tx_burst),
+		TEST_CASE(test_tap_mac_filter_info),
+		TEST_CASE(test_tap_mac_addr_ops),
+		TEST_CASE(test_tap_mc_addr_list),
+		TEST_CASE(test_tap_xstats_mac_filter),
 		TEST_CASES_END()
 	}
 };
--=20
2.53.0

