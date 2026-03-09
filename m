Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59D1F417F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 16:13:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12F44402BE;
	Mon,  9 Mar 2026 17:13:42 +0100 (CET)
Received: from 1.mo508.mail-out.ovh.net (1.mo508.mail-out.ovh.net
 [5.135.90.176]) by mails.dpdk.org (Postfix) with ESMTP id EDE0940261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 17:13:40 +0100 (CET)
Received: from DAGFR7EX1.OVH.local (unknown [10.110.37.60])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4fV2BD4sxtz7tDg;
 Mon,  9 Mar 2026 16:13:40 +0000 (UTC)
Received: from laptop1704918.desk.int.gns.ovh.net (109.190.254.56) by
 DAGFR7EX1.OVH.local (172.16.2.20) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 9 Mar
 2026 17:13:40 +0100
From: Xavier Guillaume <xavier.guillaume@ovhcloud.com>
To: <dev@dpdk.org>
CC: <stable@dpdk.org>, Xavier Guillaume <xavier.guillaume@ovhcloud.com>
Subject: [PATCH v2 0/3] net/af_packet: fix MTU handling and add jumbo frame
 support
Date: Mon, 9 Mar 2026 17:10:18 +0100
Message-ID: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
References: <20260306092013.2205076-1-xavier.guillaume@ovhcloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.56]
X-ClientProxiedBy: CAS1.OVH.local (172.16.1.1) To DAGFR7EX1.OVH.local
 (172.16.2.20)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 17416545662000116081
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTFX7Ywr2E4ILOcrMbVpx+Fq3/ZT3Gft+2CPhKyCMWYh/WmCrXtyjnE7tlvBoLJ0XFsBYFoBQEc+Cn/txPxMferDgXHCPkWWOD+TdaVztpA78bFdevnWxz+TiMveZBaIAdbQ7KxKzBuTbfWh6uMLAT1hVqXSF6lfJ5GdT5lGi0bcbu22uJSKnRC6H8zjgQYKg1iWzWKtsuXWtX3Rc4EFr1HwjEKQS2CUG2bDaaFogySp4Q80bltdNfW15DUzH5VHzVR1Qi+iVlasVutaGg65JIKGlQyN7JmC2fvdvpa36Pr/F7jUmizfJvxKPy/OLvcgZyFR29jtYa/GYAcdVu/lI6PpBGR9T8eRYfqHGVDCYqXQBAyay5FSqJMiosG9kcEPUNXOaVEAbyR5VyPLxQH7TsC7826mMjVrpiG1pftSV3zeaciFTWNKbLwHVISA8ZNMd7Yfm97XbVuwwbpiACRCNNgI/07XKQJZp0+ds/0uEhaoN9r+CAgiNPyRvYYqtKeLbDeD0FWYMF10id/KegDfVfDtO0ZjMXiEf2C0iEEc86DaGDLjm7FWfGIj75yHN//lLYoIktrOXjE8hy6U56kXhDA4pT5yzMNdAuIPg66ST6+bgxafYo1tSS/R/lrHEh7IamLeTSHZn30myB5//cE9pF3Xob0xkS4NdNkTKuHmgpGMnQ
DKIM-Signature: a=rsa-sha256; bh=d86nHD+6HRANhH97Lukn1JTR34koBGCeNYF1gWOsreA=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1773072820; v=1; 
 b=Mj/ZnX1+ppqoEONwRdnMLT639DjK4h8kwgvE+uhvo4R+9rk6EKS7o4/hUi40jc5ne0jFIuMZ
 Qmv4OvCGg8IheZaB7SIUx17MnFzwsIRTS1grrE+F7DrOmlUIYOeHpryeC23cKM1MBjIbVeEUc3V
 LiAgKUrgfFcgD4Ls6GYn44Yo=
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

v2:
  - patch 2/3: fix Fixes tag to use 12-char SHA (checkpatch warning)

Xavier Guillaume (3):
  net/af_packet: fix MTU set data size calculation
  net/af_packet: fix receive buffer overflow
  net/af_packet: support jumbo frames

 drivers/net/af_packet/rte_eth_af_packet.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.34.1

