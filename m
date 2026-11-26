Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BF8606A321
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Nov 2026 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=georgmueller@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=EpovnnVQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6D1E402B2;
	Fri, 27 Nov 2026 10:17:03 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by mails.dpdk.org (Postfix) with ESMTPS id 3109E402C9
 for <dev@dpdk.org>; Thu, 26 Nov 2026 18:05:21 +0100 (CET)
DKIM2-Signature: i=1; m=1; t=1795712720; mf=PGdlb3JnbXVlbGxlckBnbXgubmV0Pg==;
 rt=PGRldkBkcGRrLm9yZz4=; d=gmx.net;
 s=s31663417:rsa-sha256:cTYvZD840MX6iAhlBSlf7w28dOai
 6SCKXbzRCwC2OUzbzXOwAY3AJCrB0PY78GRQDaYzEwsPq1nkjFq/1c46rqnXAaUq9BSmCExYfbu
 n9pNTBZIU6SkxClhHmbffQ0oXEdWtYRiOyGtdtr7jBVciF1C0+8E9j68B/ccxHTRqVZIWGh9Dcl
 5nFXJni0EL1qYZD8erllddC5FBxE8ykH2ZUHwV+zHOHlLfNo4Jx+wDW50NHysdqcLyNrIBV54T4
 +cTGoQGE1ooRzg7ZAxeAYLC+PQ7KuJC6+BvDU6UXRm3XgH93QmYExbUdYogUJ9yv6ysGVm8hpCs
 2mQZkpPYIot3Bw==;
Message-Instance: m=1; h=sha256: ZeT260u0e5ucSjA1Ik6WcIQ7JtSXsm/uYoz/Uaxtt+E=:
 eJQpYjfVRKqNm6Ar5LIxStxcJtPaYaH0+Isk/IsbPRw=, sha512:
 P8PkmGe9kfdYPA0azFjKOg6VqnIwkvhFRBHd4SXk9DqpIIcKkS3dS4YL3Cg1s3q1UOSXwHiX4BsVBjrB0ZvodA==:
 a53QbO9kN42JCtsPjIPGSgVus94mXD753JO4cvZLvzYm3TdFmbdGLyGufxocHXogINKuhHdiNJFFDAEok0vP4A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1795712714; x=1796317514; i=georgmueller@gmx.net;
 bh=N3b15DFTicUirxUHgRJu6mGo8YQ2n/snqzoPwXGUjCE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EpovnnVQlWu6z8rQ7nnbauZ4lKHFpn7IHfT9Yl3hQn8EclOcyB8CWa8fN+2sMeFd
 9tXDc43HnJnJL/ruA/JjsGcbJJbSO/gAiXvoe2hGGLn6sJ+StuA1AG9rjNK8AD1xO
 IXByF28mIYmYNTypaRyXYIu9rgpc9QjIchyI+f/54EnU9jAs1IKeyf3AQiO4mbhIL
 FqgM3LZKJqiDR5OAG6N8thCKMEB6HRdZs2YZH9YF1lToDbmKhQQAGmZboDqtWtPVs
 yKTdrkV3EsEhviYu84V1tC5yv1U0WjU0pBzINY21E266COjVsKIr7IG3vhaxRHc+T
 jaGMe0M0fz0/yE2YJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My36T-1yRdVl2xjT-011rs0; Thu, 26
 Nov 2026 18:05:14 +0100
From: =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Cc: dev@dpdk.org, =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
 stable@dpdk.org
Subject: [PATCH] iavf: cap max_pkt_len to what the pf reports
Date: Thu, 26 Nov 2026 18:00:55 +0100
Message-ID: <20261126170503.1365081-1-georgmueller@gmx.net>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fj2x+M2iErdDWYgIYf/EvjIjD88fGsdabbUjiw9AWAmx65OK1x3
 j69uvyDNwfdBEnd5qJ1kVjx3DwqGWuoyxE7r82sKgQ6kOD8+x7Wh2ZYLd/or5KgTYjn4b/w
 d+HpIV5prPltkWYhRQbvrjbojzfwvJAA1npP3JnqzzV9MjqE4JYjz7ywuKcJF3vmsEd98j8
 It0mpDRpJIL/DD0cl8g6w==
UI-OutboundReport: notjunk:1;M01:P0:X2BvqVekhfQ=;wx+AqiFb8qie70Eb/pWl7qaXtDc
 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
 c5QS6HVdxUCKwUXGsQ==
X-Mailman-Approved-At: Fri, 27 Nov 2026 10:17:02 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Linux PFs report the max frame size in max_mtu of the VF resources,
minus 4 bytes for a port VLAN, and reject VIRTCHNL_OP_CONFIG_VSI_QUEUES
with a larger max_pkt_size. With a port VLAN on an ice PF and an MTU of
9702, starting the port failed with "Failed to execute command
VIRTCHNL_OP_CONFIG_VSI_QUEUES".

Cap the max_pkt_size sent to the PF to the reported value, like the Linux
iavf driver does (399c98c4dc50 "iavf: Fix set max MTU size with port VLAN
and jumbo frames"). A reported 0 is ignored. ice adds the port VLAN tag
back on its side, so frames at the full MTU still fit.

Fixes: 69dd4c3d0898 ("net/avf: enable queue and device")
Cc: stable@dpdk.org

Signed-off-by: Georg M=C3=BCller <georgmueller@gmx.net>
=2D--
 drivers/net/intel/iavf/iavf_ethdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf=
/iavf_ethdev.c
index 10069feae2..dd0f4cfa9a 100644
=2D-- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -1046,6 +1046,9 @@ iavf_dev_start(struct rte_eth_dev *dev)
 	wb_on_itr =3D (vf->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_WB_ON_ITR)=
 !=3D 0;
=20
 	vf->max_pkt_len =3D dev->data->mtu + IAVF_ETH_OVERHEAD;
+	/* the PF reports its max frame size in max_mtu, 0 if unknown */
+	if (vf->vf_res->max_mtu !=3D 0 && vf->vf_res->max_mtu < vf->max_pkt_len)
+		vf->max_pkt_len =3D vf->vf_res->max_mtu;
 	vf->num_queue_pairs =3D RTE_MAX(dev->data->nb_rx_queues,
 				      dev->data->nb_tx_queues);
 	num_queue_pairs =3D vf->num_queue_pairs;
=2D-=20
2.56.1

