Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7988EB104B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 11:21:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96B6A40664;
	Tue, 10 Mar 2026 12:21:43 +0100 (CET)
Received: from 2.mo15.mail-out.ovh.net (2.mo15.mail-out.ovh.net [5.135.90.179])
 by mails.dpdk.org (Postfix) with ESMTP id 13E2E402DC
 for <dev@dpdk.org>; Tue, 10 Mar 2026 12:21:43 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.110.0.234])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4fVWft5rGdz3wqK
 for <dev@dpdk.org>; Tue, 10 Mar 2026 11:21:42 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 10 Mar
 2026 12:21:41 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Subject: [PATCH v3 0/3] net/af_packet: fix MTU handling and add jumbo frame
 support
Date: Tue, 10 Mar 2026 12:21:19 +0100
Message-ID: <20260310112122.2930093-1-xavier.guillaume@ovhcloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
References: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.56]
X-ClientProxiedBy: CAS1.OVH.local (172.16.1.1) To DAGFR7EX1.OVH.local
 (172.16.2.20)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 18358360934831567264
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGUMtlrB8NvDWyrIFgd9vPeh5wE/1Aq8XERSU6szKcyggOJOK+CKqoxMRqHt3FDT8sgDJ4nC8uCCj6gi8Ml3gtQFLe3+Z7Vem0JQ8RLloqFz4MuC8q3/pXsEcad2VpLAndiGH3Bjd7E9jeCSDe0qUqmxad+Ae6weDCbq8o3eJRh/gVxRBVBwNJN6tSEo0R2d88jUzizjrIY8/4dbjcRn3nw+9NYzkibyVRCqHFxkoVNAGzlh1Uu3HPH1jfrT1Jh1mYPEgi1gLSQb+WtTwc417pNmESPXNqGAQq6801IeXvqHYBSt/YND61juaJhPVFAM5Unmtcx2AUdyI06tJV33DIFbdPArjFrHSSv+59g19O9SDWxI5Wn2wUbhCd4xbTW7+fZ8EJ0qI5N6vci/wveiYZ5rxtbmLppC6h8fgXQ3v6ZDCyj4xqeQcoadY4U7h58i1wmlYOAV6f9aWeypaQOqaAIqX5ZAt2acix9UG1oRN3xVwxPllnexcu0IJJpWOeeL4+lEnajT9Ri8a1x3ai+iP501RtAHYz8jMaZjZnqR5cDgzf9HUXCftwnOuG5WUGuQryL9xKWy4llU2wSruz5lAc9FhibDiaY6Lhe1uNYEUG4XZJalMBUgVkMU92SI82HHuDE7KP/ZHxGE3HRo02f/P0wf7ayny6gd+ANH4GkIXOH2w
DKIM-Signature: a=rsa-sha256; bh=ZZLRidsOaBkfZATkqV4gNr9r1MUOaegiNb2bKIlcYyk=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1773141702; v=1; 
 b=MLauqMdbVNqe67M45CY6KlpVUI7lowNbcvUf7yRiXci443KbSXEf+/z2bN+mfsY5KHrU3rRP
 xF2l8B+RUufv2WNFIkpShCT5tWZYvBoLW8aumQmCv8KwTvbnJhoGl0WssHJArVVG2kctZgNOozW
 PYuPDjrh60L9Iy2lDu4PKfxw=
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
Reply-To: xavier.guillaume@ovhcloud.com
Errors-To: dev-bounces@dpdk.org

This series fixes two bugs in the af_packet PMD related to frame
size calculations and buffer safety, then enables jumbo frame
support by deriving the advertised capabilities from the actual
TPACKET ring configuration.

Patch 1 fixes the data size calculation in eth_dev_mtu_set() which
is too restrictive due to TPACKET2_HDRLEN including sizeof(struct
sockaddr_ll) even though the sockaddr_ll does not consume frame
data space. The formula is now consistent with the RX and TX paths.

Patch 2 adds a bounds check in the RX path to prevent a heap buffer
overflow when the kernel delivers a packet larger than the mbuf data
room (e.g. if the kernel interface MTU is raised externally).

Patch 3 replaces the static max_rx_pktlen (RTE_ETHER_MAX_LEN) and
adds max_mtu, both derived from the configured TPACKET frame size.
This enables jumbo frame support when the user specifies a larger
framesz devarg at vdev creation time. Since the ethdev layer now
validates mtu <= max_mtu before calling the PMD, the data_size
bounds check in eth_dev_mtu_set() is converted to RTE_ASSERT().

v3:
  - patch 3/3: convert redundant data_size bounds check in
    eth_dev_mtu_set() to RTE_ASSERT() (reviewer feedback)

v2:
  - patch 2/3: fix Fixes tag to use 12-char SHA (checkpatch warning)

Xavier Guillaume (3):
  net/af_packet: fix MTU set data size calculation
  net/af_packet: fix receive buffer overflow
  net/af_packet: support jumbo frames

 drivers/net/af_packet/rte_eth_af_packet.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
2.34.1

