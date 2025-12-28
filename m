Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A37CD3B7E5
	for <dpdk-dev@archiver.kernel.org>; Sun, 28 Dec 2025 18:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18FFC40658;
	Sun, 28 Dec 2025 19:46:00 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id D536640649
 for <dev@dpdk.org>; Sun, 28 Dec 2025 19:45:48 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42e2d02a3c9so5199917f8f.3
 for <dev@dpdk.org>; Sun, 28 Dec 2025 10:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766947548;
 x=1767552348; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zaz5hrgCnNp873lhNmZ9Pm/5apsXNL+UG/H1WiUC1hA=;
 b=KMNf7lHnLVvFLYUPweYANc9hjjQY6nAJLNR5TXrBdcjXz319uRfRcjSVDjQgBlV4gp
 oAg58HYpr9fvHWK6LScTorWgBceq28Qn4xiMP+XYr+dUg3/QYa97HlSPlwPSJbEs1MVA
 3wDJQMZW789Q+K+6O5vTERa2Gl4DmGLqztIRQuSIOftX4yue3LIcp5ibG/hRkYXqgNAR
 uY+o29CChlteICl8ZiZCoeKv5wx/YRMSMZtFJpxbyfMN3PiaWQreadUJhL2EzU5IiBOX
 X6SQXIT7UMp+Ov5kiKSOWVh9hxK4TfrdWmuk4sUzTebuCd/qXwooiJzwOtV1Q6h5AFzM
 O41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766947548; x=1767552348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zaz5hrgCnNp873lhNmZ9Pm/5apsXNL+UG/H1WiUC1hA=;
 b=oINMy9HjHwB+OGGls/6ne8WtMJeXPoc/M9XMIU401ZCSiGjnlqtJshs0PTKq4OOkMy
 YOY6PnrGX6bgn/GFRDAll3NlSnXrY83QcdnhHQcow39FUaA/K0qyYfi0es76FcTIQqQT
 crR54O05UICx/bDezNRzdL2tqRsctxWSkfkA9DXgi0264knUHzwAz2eaASvhFnIcyvox
 NpxoCE+PbzPIvy+SXysC6PmfiiYx4/O1s5A5NpihecF1nKkq3aslO9C8/PIYe5SokQzh
 TCXgiWwTTVJ5RMNFG+pKJj2iGHDL5BHKsU13bw4BEMH7/FU8gb7dSw9dQSXE+GVdlMI8
 57sw==
X-Gm-Message-State: AOJu0YxwDUGRY0TWEp0ZqxBJO0xMFsUKDA+zD97NDntjNyzjnajSODuC
 aW1Tls8hoagaX1rB7Fr0aDvLAKFDdNuUQChvAXoP9KgKtSwXAiwdS/VHGs/iM2JQsOaDnsg1N89
 dL2DGFG8=
X-Gm-Gg: AY/fxX4n3S4lv4Aei1OfOsbj1wlVhHV4chrT4QODF8cvTRkovt1F2u9pOpiSMFOSIdF
 Cl2DZRFgk9xNgxaPws/fn9E7drwwpULHBFNFeEhXThlSickg7i7nKEP/ZinCNOWCPiJynKssmwv
 U63ImtazWoNWgXDg2EEOgbu67//nd3mnqTEG4a8CEY9pyp8lyCVPsBTVUSX/TKLfuGc/QQj6GCB
 NQacR64LzVK0n2f9i3oALC7fBFvev9F09p+0BF65JIIVjxEwU6RA8WcqxaAmL3s+jX7Z/yLuQWj
 8m4w7cEH8iW/IvC40Ohkgezw9mAmN0OaRoYVB2LhbleOL5J7V++mtlrr9cdul2wcgbpseHll/In
 wBiSv3GQM6jLas8lWGqabyx96tWZfXpH/HHFbwZH6e2Ixp9IE+vwUNQV/AyFWRQjuWjboIBiZKq
 Gllk8SfzgNJUq4sk4YGGO70YBpkZU9mm7D+I7SAh6abQLwdFjGmg==
X-Google-Smtp-Source: AGHT+IHm+sGIqYpa1Qb0qpud426BSt4D21mUkIJdHA3/UH50sm1A+U1BdU4ZZ0SKc0GkLFWptbhzsg==
X-Received: by 2002:a05:6000:200e:b0:431:9dd:2cca with SMTP id
 ffacd0b85a97d-4324e4c126fmr32068653f8f.7.1766947548431; 
 Sun, 28 Dec 2025 10:45:48 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2bdfsm59150275f8f.32.2025.12.28.10.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 10:45:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
 Mike Baucom <michael.baucom@broadcom.com>
Subject: [PATCH 5/7] net/bnxt: fix uninitialized warning
Date: Sun, 28 Dec 2025 10:40:18 -0800
Message-ID: <20251228184300.541639-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228184300.541639-1-stephen@networkplumber.org>
References: <20251228184300.541639-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

With gcc-16 it inlines a lot more code and creates a warnings
where it thinks it might be manipulating bits that are not set.
It looks like this is because the bits in control word (cword)
in theory could be larger than the variable. Should not
be possible because wc_ctl_size_bits is only set to 3, 16, or 32
but that happens outside of the scope of these functions.

Resolve by adding bounds check which compiler sees and knows
the loop will only see those bits.

In function ‘ulp_bs_push_msb’,
    inlined from ‘ulp_blob_push’ at ../drivers/net/bnxt/tf_ulp/ulp_utils.h:407:8,
    inlined from ‘ulp_blob_push_32’ at ../drivers/net/bnxt/tf_ulp/ulp_utils.h:551:7,
    inlined from ‘ulp_mapper_wc_tcam_tbl_dyn_post_process’ at ../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2487:9:
../drivers/net/bnxt/tf_ulp/ulp_utils.h:336:17: warning: ‘cword’ may be used uninitialized [-Wmaybe-uninitialized]
  336 |                 ulp_bs_put_msb(bs, pos, 8, val[i]);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/net/bnxt/tf_ulp/ulp_mapper.c: In function ‘ulp_mapper_wc_tcam_tbl_dyn_post_process’:
../drivers/net/bnxt/tf_ulp/ulp_mapper.c:2443:18: note: ‘cword’ declared here
 2443 |         uint32_t cword, i, rc;
      |                  ^~~~~

Bugzilla ID: 1821
Fixes: 3fe124d2536c ("net/bnxt: support Thor platform")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnxt/tf_ulp/ulp_mapper.c     | 5 +++++
 drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper.c b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
index 0ff952950b..960cdda311 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper.c
@@ -2446,6 +2446,11 @@ ulp_mapper_wc_tcam_tbl_dyn_post_process(struct bnxt_ulp_device_params *dparms,
 
 	slice_width = dparms->wc_slice_width;
 	clen = dparms->wc_ctl_size_bits;
+	if (clen > 32) {
+		BNXT_DRV_DBG(ERR, "Key size bits %d too large\n", clen);
+		return -EINVAL;
+	}
+
 	max_slices = dparms->wc_max_slices;
 	blen = ulp_blob_data_len_get(key);
 
diff --git a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
index f99698a1d8..2d89f10d5e 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_mapper_tfc.c
@@ -90,6 +90,10 @@ ulp_mapper_tfc_wc_tcam_post_process(struct bnxt_ulp_device_params *dparms,
 
 	slice_width = dparms->wc_slice_width;
 	clen = dparms->wc_ctl_size_bits;
+	if (clen > 32) {
+		BNXT_DRV_DBG(ERR, "Key size bits %d too large\n", clen);
+		return -EINVAL;
+	}
 	max_slices = dparms->wc_max_slices;
 	blen = ulp_blob_data_len_get(key);
 
-- 
2.51.0

