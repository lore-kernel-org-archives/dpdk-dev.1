Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2F1ECD997
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 21:31:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 061F34065E;
	Thu,  5 Feb 2026 22:31:09 +0100 (CET)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 38F9140666
 for <dev@dpdk.org>; Thu,  5 Feb 2026 22:31:07 +0100 (CET)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id E0CD01400088;
 Thu,  5 Feb 2026 16:31:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Thu, 05 Feb 2026 16:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1770327066; x=
 1770413466; bh=FT2JN7CV9KCe/lj/F6G2cS6eCYysy6hQ+SmdiOm3lAQ=; b=E
 n0znm1sKEYTWc0TsfmtOlc+DQ8f/p0p0RcymTbpAR3RCLHMWRwaSsjUzrrkNxUDO
 CyBZT5Coq6KazNnfKaT9MSPMjBxYZntWWZwfp6MwYgROt5gJpii+77c/H7leK88P
 Psy+HASqlfnv+9CDH6k9uUFWOdWW6E+6L2YUkloEdD+FdVHXwf/fgKmVwRlde+7r
 BEWSujwWckNZJ6wLewNeApzbWOGkl58/Z+I9epbq5HrO8xYJYkHU1/KQGyjiy2RR
 f22qnNpISRtcUZyrxomQnzY1As/muOPKNH/QygAN8I6Toab+3FWuTNYFo2rote9W
 eDJdsJw4zYSzU4ejg2Emw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1770327066; x=1770413466; bh=F
 T2JN7CV9KCe/lj/F6G2cS6eCYysy6hQ+SmdiOm3lAQ=; b=atnymW+j4HwJRvQF9
 DBsToVum4zH8Jxxaq7BEllJ8LBpIdjx/WPFv3v8MqoguFelo8+vC8dmDRzyGW3Oo
 HvUIyWoqdvs8Gh2714TxHXKj4D/JbWXd185vSVAYN3UU5yYRc2QoA+jBKeLBzjqH
 1xjiR0e+2iZ8IuS75vqlKUS/Cd2/aOgsxd8Nt6PGZ86ew2I6sbWEXOT6I67i6SxY
 lC/kDdUuaN/EKM0CKTfQGT7/xzxQI3WWHochCYZoNblAbIGodnO2BYE2ysLqchdX
 LJXJBz2EyTKsiTppn76K19eHZXTcag3xxeyt8VKRmxNXWmLvrGfw0munowvmPR9W
 KzQMA==
X-ME-Sender: <xms:GgyFael1pt_kOzVHdFNc5KFwX6vRgoeES7o-pgarTbZXIC1xwGdTnA>
 <xme:GgyFaaJ1MyYR_Dyf_gU5mVQQcnnNY4joCwiBFqc9-x3iGM1yGrhcxxni8LXfZ1JrL
 QiKNUDlmBMMVLoJf3Ok_q3eKkrGQwKoQu1wkAjtC2sA2sA3p8gObQ>
X-ME-Received: <xmr:GgyFabxUhUjt7t9ZGvyINkEBjrfLByW0Rc9H_eXmEOHuG7pqRpb9ywkteFxcsZM6h-THoULG40M25E_WI-Q2XHM5AViOYcM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeefpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopegurghvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthht
 ohepvhhlrgguihhmihhrrdhmvgguvhgvughkihhnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:GgyFaavzB4LSa8jD3cemKn_hxmDtmwEstm92jB1JFshZVl1GPaqenA>
 <xmx:GgyFaStqcKIMyUnyDZ3Le4BHIOVaHMpUimheORUe7pADLe0jzzI7Qw>
 <xmx:GgyFafNZrjsGgkg1H6uKlvp3YVyLiJx4D5T31k1LxrPd-_3p5mLJSw>
 <xmx:GgyFaQ0ach7mLkMPH_4XxeyzHfqtNEkc5ch42ptEl14uc4ihkIehig>
 <xmx:GgyFaXG9ezTDJCa_cIBc3DEyN_tt4TEs_1fe2FrWFxwyrbLciBUHOwx9>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 16:31:06 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: david.marchand@redhat.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 08/11] net/iavf: fix minsize build
Date: Thu,  5 Feb 2026 22:27:40 +0100
Message-ID: <20260205213044.702908-9-thomas@monjalon.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205213044.702908-1-thomas@monjalon.net>
References: <20210412215339.2439530-1-thomas@monjalon.net>
 <20260205213044.702908-1-thomas@monjalon.net>
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

This error is seen in build of type "minsize":

In function 'iavf_ipsec_crypto_supported':
    drivers/net/intel/iavf/iavf_ipsec_crypto.c:1649:29:
    error: status may be used uninitialized
        [-Werror=maybe-uninitialized]
 1649 | if (rc == 0 && status.status == INLINE_IPSEC_STATUS_AVAILABLE)
    drivers/net/intel/iavf/iavf_ipsec_crypto.c:1647:46:
    note: status was declared here
 1647 | struct virtchnl_ipsec_status status;

It looks to be a compiler issue because we are not supposed
to reach this point in case of iavf_ipsec_crypto_status_get() failure.

The variable is initialized to allow compiling with "minsize" option.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index d5bfbecf08..6d41b1744e 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1644,7 +1644,7 @@ iavf_ipsec_crypto_supported(struct iavf_adapter *adapter)
 	/** Capability check for IPsec Crypto */
 	if (resources && (resources->vf_cap_flags &
 		VIRTCHNL_VF_OFFLOAD_INLINE_IPSEC_CRYPTO)) {
-		struct virtchnl_ipsec_status status;
+		struct virtchnl_ipsec_status status = {0};
 		int rc = iavf_ipsec_crypto_status_get(adapter, &status);
 		if (rc == 0 && status.status == INLINE_IPSEC_STATUS_AVAILABLE)
 			crypto_supported = true;
-- 
2.52.0

