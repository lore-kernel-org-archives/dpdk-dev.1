Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEB3C88E77
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:23:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC23742E8D;
	Tue, 15 Sep 2026 21:22:54 +0200 (CEST)
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by mails.dpdk.org (Postfix) with ESMTP id 6E93C42E89
 for <dev@dpdk.org>; Tue, 15 Sep 2026 21:22:53 +0200 (CEST)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39d654f02baso94757a91.3
 for <dev@dpdk.org>; Tue, 15 Sep 2026 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789500172;
 x=1790104972; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHbSVBvRTXfogKnUzQMuvETKpUpknjhbxMe7G8Hl0mo=;
 b=kEQlE294OzQ/jg2Z8VDM2XIC12xrDaohfQKEAKOLEGtHs5OLo3gci87HmbQ4CXed/Y
 iBDGgk6Nxbyv1F8U5TAC/fDW4zNbm/WnaYaU1SJ6JoFeqmyWOPAT7bz7OYQZDlVfZnJC
 453rYEr+AutDZiWxJW0k/wEznaIs2of5TTIGi0EfjS5BzDxI06o0sR7bo/GZPDLY7HPq
 brMo3Nmlrhafys9g0T3DlDAckg8VM7KO0Esl5EAQVrumbqBebjQh/Hqfp8HlyIE6rjZg
 sIhW/0oRTEmtauG8m/qv53GBLwni68zNQl0ISah48VJw7kZz1dEmn1hNbHtVSJp+CE/L
 aznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789500172; x=1790104972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OHbSVBvRTXfogKnUzQMuvETKpUpknjhbxMe7G8Hl0mo=;
 b=Kfd7Kcsn57+DsCi7JcaAQ+VeZC7jybO7UazEbxX8i9F0Jgn6HI/d7fvZCnB9p6+Czm
 kZDtoacig9hIS3ODj1bOgNuA7x+jtCjbtzAl/x8zzhqqL4ISGEXqUAo9f4j+vmL4p/8k
 ALrVWI6udbq+oMTsyJtGKbtSKk1GOf+nFDXzOzOdsyn1Fok56fZK9gst30Hl14JpFtA1
 ORD5E7HkG1tVBNBZLgnMeEyK7pnwqWyr71TpJ1BUTmh6cQ6LJrRJ88gDKlXYwE/9k2Xm
 wOpHuij247WscnG6oor64Q7QnsW+nJByBFN2sIAseUd5iJbfTxzkRbCX3DCsgEYTt0iW
 PixA==
X-Gm-Message-State: AFuF++mYpaBXgAQp0GL6T1X7AuVghQdrX8lbNxZKPbl5WCBmvN+OM1P7
 J4/58ASiUC2YaUKaHevNnXoA1U8M/730vSLjjN24Y3TEmAeERbOWJ6Iq2H8GOrfJwwVWowanVJ7
 0XX9VPp6z/w==
X-Gm-Gg: AYBFou1fesHIu4ZZLavdhDlp7OvoVyOONo5QltHD2yaFbD1jA7+MbE22t3LbVitmu94
 QFrG+FD5dT8aXuwpwDVWoq6RIFkNRd+Kfcek7/9ylsGLtKL3RwfubymznIZSMYMidxmfloB9MUU
 ihc4yqeN7FlbS87QdODEyEt3ZQjBsyeipKgB1T8IAgRjXcAlhRbvYp7PFV2SjZHM5XT99+HWbZF
 oNNBQfaFOXmbf5zWAEhmh0H9NMPoaundV6uH2SdQinIf5TCMVHASxn3ECR71rE1TaszAifwvxrJ
 fpdQGsIcTIC4Cm5ZIpZu/XLCUcd/m+cErQMwjCK0RM3arD+DU9MIFOcs/8lgsmiEckD6crP5bAt
 uqQDh6Hk4OC5ftXztIk6dVcBdC54HNq9jl2YZ/07aglVzWjSXjY5FtGMH3YoYA0Ig2hsVv/b7y7
 hojNjYk6UthiuOuJSBjI/GicGn842Zvx5r0IdXGczOZyWSmSY7L/qDPd5qVqiF9meTOK7/81yiO
 DQtrz+ZpxDLtBl5UEWE6IpxrK8KGEe4F4WwUQ==
X-Received: by 2002:a17:90b:4b81:b0:398:cb56:e92 with SMTP id
 98e67ed59e1d1-39debfb92b4mr16160874a91.11.1789500172501; 
 Tue, 15 Sep 2026 12:22:52 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e1bbfdd49sm217535a91.11.2026.09.15.12.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 12:22:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>
Subject: [PATCH 11/18] net/intel: use secure random for default RSS key
Date: Tue, 15 Sep 2026 12:21:09 -0700
Message-ID: <20260915192207.3926217-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915192207.3926217-1-stephen@networkplumber.org>
References: <20260915192207.3926217-1-stephen@networkplumber.org>
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

When the application does not supply an RSS key, these drivers built
the default key a byte at a time from rte_rand(). That generator is a
fast non-cryptographic PRNG whose state is recoverable from its output,
so the resulting key is predictable. Linux fills its default RSS key
from get_random_bytes() for the same reason.

Use rte_random_bytes() which takes randomness from the operating
system, and propagate the error where the caller can report it.

ice_get_default_rss_key() has no way to return an error to its caller,
so it keeps rte_rand() as a fallback if the system random generator
is unavailable.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/cpfl/cpfl_ethdev.c |  5 +++--
 drivers/net/intel/iavf/iavf_ethdev.c |  8 +++++---
 drivers/net/intel/ice/ice_dcf.c      | 10 ++++++----
 drivers/net/intel/ice/ice_ethdev.c   | 11 ++++++++---
 drivers/net/intel/idpf/idpf_ethdev.c |  5 +++--
 5 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 4315adb68c..c3f18686bb 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -478,8 +478,9 @@ cpfl_init_rss(struct idpf_vport *vport)
 	nb_q = dev_data->nb_rx_queues;
 
 	if (rss_conf->rss_key == NULL) {
-		for (i = 0; i < vport->rss_key_size; i++)
-			vport->rss_key[i] = (uint8_t)rte_rand();
+		ret = rte_random_bytes(vport->rss_key, vport->rss_key_size);
+		if (ret != 0)
+			return ret;
 	} else if (rss_conf->rss_key_len != vport->rss_key_size) {
 		PMD_INIT_LOG(ERR, "Invalid RSS key length in RSS configuration, should be %d",
 			     vport->rss_key_size);
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index d601ec3b6a..fcef1eb26a 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -565,12 +565,14 @@ iavf_init_rss(struct iavf_adapter *adapter)
 	/* configure RSS key */
 	if (!rss_conf->rss_key) {
 		/* Calculate the default hash key */
-		for (i = 0; i < vf->vf_res->rss_key_size; i++)
-			vf->rss_key[i] = (uint8_t)rte_rand();
-	} else
+		ret = rte_random_bytes(vf->rss_key, vf->vf_res->rss_key_size);
+		if (ret != 0)
+			return ret;
+	} else {
 		memcpy(vf->rss_key, rss_conf->rss_key,
 			   RTE_MIN(rss_conf->rss_key_len,
 				   vf->vf_res->rss_key_size));
+	}
 
 	/* init RSS LUT table */
 	for (i = 0, j = 0; i < vf->vf_res->rss_lut_size; i++, j++) {
diff --git a/drivers/net/intel/ice/ice_dcf.c b/drivers/net/intel/ice/ice_dcf.c
index 3b635c0822..b73af13d5b 100644
--- a/drivers/net/intel/ice/ice_dcf.c
+++ b/drivers/net/intel/ice/ice_dcf.c
@@ -1125,14 +1125,16 @@ ice_dcf_init_rss(struct ice_dcf_hw *hw)
 	 */
 
 	/* configure RSS key */
-	if (!rss_conf->rss_key)
+	if (!rss_conf->rss_key) {
 		/* Calculate the default hash key */
-		for (i = 0; i < hw->vf_res->rss_key_size; i++)
-			hw->rss_key[i] = (uint8_t)rte_rand();
-	else
+		ret = rte_random_bytes(hw->rss_key, hw->vf_res->rss_key_size);
+		if (ret != 0)
+			return ret;
+	} else {
 		memcpy(hw->rss_key, rss_conf->rss_key,
 			   RTE_MIN(rss_conf->rss_key_len,
 				   hw->vf_res->rss_key_size));
+	}
 
 	/* init RSS LUT table */
 	for (i = 0, j = 0; i < hw->vf_res->rss_lut_size; i++, j++) {
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 76b8ff0a72..105a6636c0 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3778,9 +3778,14 @@ ice_get_default_rss_key(uint8_t *rss_key, uint32_t rss_key_size)
 	}
 
 	if (!default_key_done) {
-		/* Calculate the default hash key */
-		for (i = 0; i < sizeof(default_key); i++)
-			key[i] = (uint8_t)rte_rand();
+		/* Calculate the default hash key. Fall back to rte_rand()
+		 * if the system random generator is not available, this
+		 * function cannot report an error.
+		 */
+		if (rte_random_bytes(key, sizeof(default_key)) != 0) {
+			for (i = 0; i < sizeof(default_key); i++)
+				key[i] = (uint8_t)rte_rand();
+		}
 		default_key_done = true;
 	}
 	memcpy(rss_key, key, RTE_MIN(rss_key_size, sizeof(default_key)));
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index c13505416a..ab4d007a22 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -432,8 +432,9 @@ idpf_init_rss(struct idpf_vport *vport)
 	nb_q = dev_data->nb_rx_queues;
 
 	if (rss_conf->rss_key == NULL) {
-		for (i = 0; i < vport->rss_key_size; i++)
-			vport->rss_key[i] = (uint8_t)rte_rand();
+		ret = rte_random_bytes(vport->rss_key, vport->rss_key_size);
+		if (ret != 0)
+			return ret;
 	} else if (rss_conf->rss_key_len != vport->rss_key_size) {
 		PMD_INIT_LOG(ERR, "Invalid RSS key length in RSS configuration, should be %d",
 			     vport->rss_key_size);
-- 
2.53.0

