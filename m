Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC85C44525
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Jul 2026 09:34:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FA554064C;
	Mon, 20 Jul 2026 11:34:13 +0200 (CEST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mails.dpdk.org (Postfix) with ESMTP id 370334028C
 for <dev@dpdk.org>; Mon, 20 Jul 2026 11:34:11 +0200 (CEST)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-39c9452244aso89927671fa.3
 for <dev@dpdk.org>; Mon, 20 Jul 2026 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784540050; x=1785144850; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eOup8c8fS7bclFrAQ0AAqpgWGAgcz2mtRVk41BE49oE=;
 b=c2PSZ8G8JskrKAga0BixSKFmSyFccmTpizc+w7cMiKRasiKPwrjxvUdnQ3dh7EJvRX
 7kQJCtJajX3qm8mZrhxwO4Ni39+J9/ew4wsQZhoCHJj/cSbHfwCaQSBDoGxJ5RjxZAm2
 W2hSNU1Cclynfh1Y9zSgy4Yk8sTK59z358jREnEyvSzAoYlKP2DW6Ddy5zGS8tC9qH+z
 w0+F6XLi5spawq2UcP4Yaa1Ye66CGaOGkTrNBKtB5/ufFsEfilQ6fIawgxDHPF9Jytzv
 N63L0hozdIQk7Ry/zXbrSnKt7wn6h6/GtSh/HPIGPoTUKY6ElXw9aFeWwfolQ7SDnj3u
 PbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784540050; x=1785144850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eOup8c8fS7bclFrAQ0AAqpgWGAgcz2mtRVk41BE49oE=;
 b=JMGAT16oASFoDgPAo9UgpsxgiugorsexaILpBo92O0hYTw+naL+XvzBnMVhqPqsvNn
 VyTIPI84uCUGywac3TvPovs9pGpQc0ofaFLKxsfsC9PzWNnYIdiVwBOIOlX/L1oItvaF
 l2wv9QrvPzZgpbOxW6NazftvqoYKYBdlZ1JTPw/ZpDgdbTsxdPE/ufD4mbI7APDXoXfO
 GQXWNsZ4VHUyRvbxlJm0rDq4MTM7Ns0fqEQhwulTfxD+YoIfZasVSjz1gwTNEZgG1FXI
 St4HAM3mZkvXMts1G1vtgu08SyZ+sraw/m7R+hbEPIq+3xuQ5JKi67ee0pkSEu4Bbs5p
 HLOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro10UeXRIPrXYK7MPRK1ZI9sLNSgCMvYVFchYXcvIPQtuaarl0AHueLDO6DrEGISuj97Hw=@dpdk.org
X-Gm-Message-State: AOJu0YyJ+3JfJVphWQpaRKuf+rr5Wp2E+QDOHAbNk9+rsRvA5xBZhLXw
 TRsch7FPE+5a+DV73xUMG6hnk1QKLJ/3nqV2IXGqyCSBRc4oD/wTfCRQ
X-Gm-Gg: AfdE7cmkT20Y3W6IAvocRbEQafxDYudw8nS8SLCjisN0sHgxTftcuzs7sikNvHMEI+B
 guzboh5yE/6v2uUHtvS7Pi5AoJVpgGjbcOKaSv7UfHbfkMsFH6n3X2Gs/SYr6X4lLJE/4BR9CEs
 vlM0QLA1RrH0pSvnj38MksYLNoIlaflvMYg0deZ+G7xTY/VTZPE3jeMMnpDqzgQOsHqTuZVqQa7
 qdJkwMNw6NHLRZ87Na/DM2/mpQA4TA73m4ofuNR2FCiNXYs9aFJ+ryftfOcsWuTViPADguqffAe
 GWrpTn6nexFRy20lQY5eBy4yJEr0A5AuHdLjfVYaut0RTt8FQpjpQXqpai4ZIrhjdI1bF2i4RjC
 mNfxldfPOL99Y6GD7ha7h8G39vprPnbxn6BP5YwfOh/ct+HJaPIRDU6CkhuLejtlssrGdHbaxBm
 nQtxZtvCrChUOYjGDKn4n3rzkmpXq+tEVJFY4aQ8ITP84=
X-Received: by 2002:a05:651c:150c:b0:39c:a108:c3fb with SMTP id
 38308e7fff4ca-39eb294f27bmr26848641fa.41.1784540050227; 
 Mon, 20 Jul 2026 02:34:10 -0700 (PDT)
Received: from kernel-builder.lan ([31.204.104.167])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39eb5019d09sm16131891fa.39.2026.07.20.02.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 02:34:09 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: hyonkim@cisco.com
Cc: david.marchand@redhat.com, dev@dpdk.org, johndale@cisco.com,
 ssujith@cisco.com, stable@dpdk.org, Alexey Simakov <bigalex934@gmail.com>
Subject: [PATCH v3] net/enic: check notify set return value during init
Date: Mon, 20 Jul 2026 12:33:39 +0300
Message-ID: <20260720093338.92744-2-bigalex934@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <IA3PR11MB89877F0FA4E9EF63B478A201BFC42@IA3PR11MB8987.namprd11.prod.outlook.com>
References: <IA3PR11MB89877F0FA4E9EF63B478A201BFC42@IA3PR11MB8987.namprd11.prod.outlook.com>
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

The return value of vnic_dev_notify_set() is silently ignored in
enic_dev_init(), so a memory allocation failure or hardware command
error goes unnoticed and the driver continues with uninitialized
notification state.

Check the return value and propagate the error to abort probe when
notification setup fails.

Fixes: fefed3d1e62c ("enic: new driver")
Cc: stable@dpdk.org

Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---

v3 changes: add log message

v2 link: https://patches.dpdk.org/project/dpdk/patch/20260715103105.39417-1-bigalex934@gmail.com/
v2 changes: validate return code of vnic_dev_notify_set() in driver init section

v1 link: https://patches.dpdk.org/project/dpdk/patch/20260707112014.82821-1-bigalex934@gmail.com/

 drivers/net/enic/enic_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
index 2696fa77d4..2a1a65d8da 100644
--- a/drivers/net/enic/enic_main.c
+++ b/drivers/net/enic/enic_main.c
@@ -1887,7 +1887,11 @@ static int enic_dev_init(struct enic *enic)
 	LIST_INIT(&enic->flows);
 
 	/* set up link status checking */
-	vnic_dev_notify_set(enic->vdev, -1); /* No Intr for notify */
+	err = vnic_dev_notify_set(enic->vdev, -1); /* No Intr for notify */
+	if (err) {
+		dev_err(enic, "failed to enable notify buffer\n");
+		return err;
+	}
 
 	enic->overlay_offload = false;
 	/*
-- 
2.53.0

