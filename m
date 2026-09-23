Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E4DC98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 03:25:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B62740DD2;
	Wed, 23 Sep 2026 05:25:31 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id C30544067B
 for <dev@dpdk.org>; Wed, 23 Sep 2026 05:25:29 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 081A31D000D0;
 Tue, 22 Sep 2026 23:25:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Tue, 22 Sep 2026 23:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to; s=fm1; t=1790133928; x=1790220328; bh=f95ZHwJfX9gxXHztQMB0Z
 dKJgNc8rEwX5Vtb72/VMXA=; b=Thk3hIl7gckBiE5WjbxlGYb1ZguIPqiy5Rz6l
 qsFG2ZRuatY1xfm4v1LrM6UngCO3bLGWns2BRY96PzwFIG/bJEzTxDcDuGTO3qZN
 IFe9UC+HptlCYpX2Qh1S+tjiQmzhwkjT9mS4HnzhRUrZz0BauIljSX4gOqAdbIps
 RLiK1XKj3HYo+tByl6me1EBIBMd9rMFonppXMb7biGr8nYSYx1YrnWbbqGzQmCZY
 zCb3PUaRe4ss48Ku5aGPJlA16vxvyl566U2LGfnfHcrNMk9UxPZ9dXqAw8p4KEQp
 +tedUav4Ygg1he1vjPcD6rYbYtZ58SlwCfy0qLOnzAy1WDJMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:date:feedback-id:feedback-id:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1790133928; x=1790220328; bh=f95ZHwJfX9gxXHztQMB0ZdKJgNc8rEwX5Vt
 b72/VMXA=; b=HvMDlyqGKIg4q9lIBiVHgfb/2NHGhivk8h/eTPu+UPXUg/0lg5N
 328vMnxoWPhgh/TKomR4l8u4DRjlB0pB40kYrLGMnr2o99XAibakUOeFPe19UlYs
 Jn0c1wJEdoxUiAaBTCnv4cOyZ0cDLrg42vnaFo2dPaaYLaDtfHNsABMY0aoLWx+p
 1e0r+Zm7pI1Le/C9rZH8FpDzCUA4gRPSLa2HzoJAPwvh8IBDqjWEUpiM00MC7/EH
 92yjE9mEmmOxOtDrXk82Twrr+Yo3SO+matG973N6Us6eeGp2Bkv6qkMtKoIdyFH+
 D6teDS8gHQlj6PfcUYxAUF8mCnPEbGnajnw==
X-ME-Sender: <xms:qEazancy4DfUVAgzB9I2Y5uz4Sd5A_kteOlVRD3DeIrfcrwsMV1vlw>
 <xme:qEazajH4HWIR5vnxJxVbBB6ELqcrWmn4_MexyPKw8w9GycU-2OVdyW4qlZJ65QPBe
 LbRfN1kYUlG43OuJwWEayzdQIW7KHSrg9PfaAPrw24hjx_XtqWohQ>
X-ME-Received: <xmr:qEazarl_mwexjdBgZ_3G3Y5jIJDnwl2iYMNZswI3kl0-1QpSacwF1ArBFuUsuj5dADjhM-UnoJMxr_WWXKhNhYOrtdPu>
X-ME-Proxy-Cause: dmFkZTEzceUtGKk6d6Iklh55/dBP+TdeeswinIkyiVk+zELCaeeUQ2CA1oAY7mYG+GS9eQ
 eZfS8Mge8SEGdYOLBZ3rtETruMpBEHNb2KRM/p8FYxbs+/LY/5xm1zZoUtGuk/62vCr77x
 vChDHDz1/lVaSOpR8tivoTxp28x5o7jr5Mac91eISw3weEANpzIoJFmSJeY3OOSRdo+ZMc
 DU/V04Ij9D6tUDwBWDDsemuEvHqIbPabcNsx918oq/thcmZqjiXUk1gljANGfY6gHqNsKS
 RhcKP0M29UwCkC6bdHLR1C9fP2Dt4bV6q+68n2kgztmPdULIRCqHnUs39y8clGgb1prcjB
 wAgcFEYrdf3FMxBwR9LW7O4RjSrYI9tDqFHdcDsJaSk88jjkpKekHxaQO40vB+DJecbk8m
 zttvJroMsqdyfpzHb4f7wsDrzRbfvxbAGORMQ1G5BTjjRUx+FnrqbV27hKSTcnoxXNAGXw
 1njAIq5UbvJqPayhzMc/CUu50cMfnyI/x+vWLxhtPcdYOXLxSkI3tA4gFx/+PVoSe3fluP
 wHVqYrLjQdbrJbZjNt7KmMljER+i7ByfEASswO8hDwjPkGOzKjzot6xNX7Gpu+oKXVbeSy
 H0yy/qqV7mmvwNTlpXroNlMajmrX6LBHwdBZogmqg8fuhYFbcW3xmdz/WVPw
X-ME-Proxy: <xmx:qEazalysIcUqC4FybqVH6yqn8jGgW6PbookfP13Znl9e2ccjDOG2zg>
 <xmx:qEazanR2I1k0GWEazH_qMajEQKcBu45k90Ft2LYsSGxr9QKEe7Myew>
 <xmx:qEazaoso6wONmFTPGffggaw-qPBPdllk06HssdjEw_IcFuB9h7W-jQ>
 <xmx:qEazapsa1nyQamg235haQ8t3Aax7zfn63j473FQG7lEPwaF6dicoeQ>
 <xmx:qEazas9mbKIuBwD9Mo1mb1KpVlHtQsH7_c5IQoVo4CFGSI1cSMtfL6p8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for <dev@dpdk.org>; 
 Tue, 22 Sep 2026 23:25:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Subject: [PATCH 0/3] improve NIC features matrix
Date: Wed, 23 Sep 2026 05:20:48 +0200
Message-ID: <20260923032502.770744-1-thomas@monjalon.net>
X-Mailer: git-send-email 2.55.0
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

The style of the features matrices is a bit improved.
The table header cannot be sticky
without losing header highlight on hover.
So instead of adding header stickiness,
the table size of networking drivers matrix
is reduced by removing some rows.

Thomas Monjalon (3):
  doc: move CSS of overview matrices
  doc: improve style of overview matrices
  doc: simplify NIC feature matrices

 doc/guides/conf.py                     | 73 +--------------------
 doc/guides/custom.css                  | 91 ++++++++++++++++++++++----
 doc/guides/nics/features.rst           | 87 ++++++------------------
 doc/guides/nics/features/af_xdp.ini    |  2 -
 doc/guides/nics/features/afpacket.ini  |  2 -
 doc/guides/nics/features/ark.ini       |  2 -
 doc/guides/nics/features/atlantic.ini  |  5 +-
 doc/guides/nics/features/avp.ini       |  2 -
 doc/guides/nics/features/axgbe.ini     |  2 -
 doc/guides/nics/features/bnx2x.ini     |  3 -
 doc/guides/nics/features/bnxt.ini      | 10 +--
 doc/guides/nics/features/cnxk.ini      |  9 +--
 doc/guides/nics/features/cnxk_vec.ini  |  9 +--
 doc/guides/nics/features/cnxk_vf.ini   |  9 +--
 doc/guides/nics/features/cpfl.ini      |  2 -
 doc/guides/nics/features/cxgbe.ini     |  3 -
 doc/guides/nics/features/cxgbevf.ini   |  3 -
 doc/guides/nics/features/default.ini   | 11 +---
 doc/guides/nics/features/dpaa.ini      |  3 -
 doc/guides/nics/features/dpaa2.ini     |  3 -
 doc/guides/nics/features/e1000.ini     |  5 +-
 doc/guides/nics/features/ena.ini       |  4 --
 doc/guides/nics/features/enetc.ini     |  3 -
 doc/guides/nics/features/enetc4.ini    |  3 -
 doc/guides/nics/features/enetc4_vf.ini |  3 -
 doc/guides/nics/features/enetfec.ini   |  2 -
 doc/guides/nics/features/enic.ini      |  3 -
 doc/guides/nics/features/failsafe.ini  |  6 +-
 doc/guides/nics/features/fm10k.ini     |  5 +-
 doc/guides/nics/features/fm10k_vf.ini  |  2 -
 doc/guides/nics/features/gve.ini       |  3 -
 doc/guides/nics/features/hinic.ini     |  2 -
 doc/guides/nics/features/hinic3.ini    |  5 +-
 doc/guides/nics/features/hns3.ini      |  8 +--
 doc/guides/nics/features/hns3_vf.ini   |  8 +--
 doc/guides/nics/features/i40e.ini      |  8 +--
 doc/guides/nics/features/iavf.ini      |  8 +--
 doc/guides/nics/features/ice.ini       |  5 +-
 doc/guides/nics/features/ice_dcf.ini   |  1 -
 doc/guides/nics/features/idpf.ini      |  2 -
 doc/guides/nics/features/igb.ini       |  5 +-
 doc/guides/nics/features/igb_vf.ini    |  5 +-
 doc/guides/nics/features/igc.ini       |  5 +-
 doc/guides/nics/features/ionic.ini     |  6 +-
 doc/guides/nics/features/ipn3ke.ini    |  8 +--
 doc/guides/nics/features/ixgbe.ini     |  5 +-
 doc/guides/nics/features/ixgbe_vf.ini  |  5 +-
 doc/guides/nics/features/mana.ini      |  3 -
 doc/guides/nics/features/memif.ini     |  3 -
 doc/guides/nics/features/mlx4.ini      |  3 -
 doc/guides/nics/features/mlx5.ini      |  7 +-
 doc/guides/nics/features/mvneta.ini    |  3 -
 doc/guides/nics/features/mvpp2.ini     |  3 -
 doc/guides/nics/features/nbl.ini       |  1 -
 doc/guides/nics/features/netvsc.ini    |  3 -
 doc/guides/nics/features/nfb.ini       |  3 -
 doc/guides/nics/features/nfp.ini       |  3 -
 doc/guides/nics/features/ngbe.ini      |  5 +-
 doc/guides/nics/features/ngbe_vf.ini   |  5 +-
 doc/guides/nics/features/ntnic.ini     |  2 -
 doc/guides/nics/features/octeon_ep.ini |  3 -
 doc/guides/nics/features/octeontx.ini  |  3 -
 doc/guides/nics/features/pcap.ini      |  3 -
 doc/guides/nics/features/pfe.ini       |  3 -
 doc/guides/nics/features/qede.ini      |  3 -
 doc/guides/nics/features/qede_vf.ini   |  3 -
 doc/guides/nics/features/r8169.ini     |  2 -
 doc/guides/nics/features/rnp.ini       |  2 -
 doc/guides/nics/features/sfc.ini       |  8 +--
 doc/guides/nics/features/sxe2.ini      |  5 +-
 doc/guides/nics/features/tap.ini       |  3 -
 doc/guides/nics/features/thunderx.ini  |  3 -
 doc/guides/nics/features/txgbe.ini     |  5 +-
 doc/guides/nics/features/txgbe_vf.ini  |  5 +-
 doc/guides/nics/features/vhost.ini     |  2 -
 doc/guides/nics/features/virtio.ini    |  3 -
 doc/guides/nics/features/vmxnet3.ini   |  3 -
 doc/guides/nics/features/xsc.ini       |  2 -
 doc/guides/nics/features/zxdh.ini      |  2 -
 79 files changed, 139 insertions(+), 424 deletions(-)

-- 
2.55.0

