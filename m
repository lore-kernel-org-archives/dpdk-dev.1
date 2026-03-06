Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8AAEF36F7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 07:47:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C176B40281;
	Mon,  9 Mar 2026 08:47:44 +0100 (CET)
Received: from 1.mo15.mail-out.ovh.net (1.mo15.mail-out.ovh.net [5.135.90.178])
 by mails.dpdk.org (Postfix) with ESMTP id 8A1A540278
 for <dev@dpdk.org>; Fri,  6 Mar 2026 10:20:30 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.110.58.22])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4fS18t0gt6z3wnm;
 Fri,  6 Mar 2026 09:20:30 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 6 Mar
 2026 10:20:29 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: <linville@tuxdriver.com>, Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Subject: [PATCH v1 0/3] net/af_packet: fix MTU handling and add jumbo frame
 support
Date: Fri, 6 Mar 2026 10:20:10 +0100
Message-ID: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.56]
X-ClientProxiedBy: CAS1.OVH.local (172.16.1.1) To DAGFR7EX1.OVH.local
 (172.16.2.20)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 11267443319424430390
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFxYDeYAwVXsd+Inefgn09/5NzDCbP32110fUH0aQK50ja0+0kw0Y6JCpmMOCOpyXnY+8wvKTmveppyz9LYpnhq0jf1yEnqAbuFDVET3w6ZdKe/xTPzRtF6sQ0rIQIOlEGbmYC3UYqrfEZF6pk67DlLx5WGnUto4WDBn4XGddk9bbTVYcA6Oid9gECrNkmsT6jwWjYmLD//Dy7YyttHbNMd7l6N1z/6WC+8oFsvyj0/sQFELT89Tsa20xbspgIkakPgkbReJufL6ZDVCHhywjCwxBH2MpS0SZkIV/rAnuToc43H87177f5E5pwUxzjI7TXbnP3lkYi8VZY4Mp+4yddWj6j4V6gzhl442CMrUjp3u5l5GZXx62NaqWRQiW/qSphMuJkefou0/3ZGkrx/gEmqNcO7s2msmgBi0EC0qODNzZUZVJv6Mex0FrhhLuvhshRMwR8QCcHOQOrcDMswgHt36y4dIeIRJRtOIB4V63mUP7T8guiVVWuKfP+DJ5Qf46MQDINRVWXgbqp2FmrTYeoEYMU7m23B5a6EKdZc2gWXZi5aKesqNsVVBClA3YaG/VT1HT5wJNnl3LsE7hUJgyilDo8Ah9HBC+PInWMctIBTomgpR7JfuqXf9qVMMZuevVWqw7rpyNR93QIuJ0Tqp1hk59tMNXv4+3sQSOSejQJ7Jg
DKIM-Signature: a=rsa-sha256; bh=jWOrW4f1h4TbwxwMjwBJLYcRHOrTos70qnGdcrap8JE=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1772788830; v=1; 
 b=KkywsOjrUQP8rXDgwQdIgNK/4rbuKsB/efAI/JmI4yL5WWpyNxjNC9RftbGTLwiBTx1IYQyY
 1+E26UT9psNQCBx1xjCvjHMMa4HPODnPpTRJ3tRhVlOF5yAenJtq4J6eBdRxbbd/qs6N0CiA6y9
 JBgqaQELDevBv7AaZwyiio4o=
X-Mailman-Approved-At: Mon, 09 Mar 2026 08:47:43 +0100
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
framesz devarg at vdev creation time.

Xavier Guillaume (3):
  net/af_packet: fix MTU set data size calculation
  net/af_packet: fix receive buffer overflow
  net/af_packet: support jumbo frames

 drivers/net/af_packet/rte_eth_af_packet.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.34.1

