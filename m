Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255D4CD5BD0
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 01:35:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08F8340293;
	Thu, 28 May 2026 03:35:15 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id D22134026F
 for <dev@dpdk.org>; Thu, 28 May 2026 03:35:02 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-516cc5471bdso91431301cf.2
 for <dev@dpdk.org>; Wed, 27 May 2026 18:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779932102; x=1780536902; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOAliQEKehOielf67P4GdnK3HfBj5fKy6QiXICQWLME=;
 b=QQYHXZMpdBvbtsXUAQuUSzwp47xZiEvT3vuCZPOyHylTRRQTS0vTs11LDLe3kYZFj8
 N6J813GAC+OpYVH1A8qdcxa5HaNyBECyUj8oHLE2CVD1c7pPtfJvXDZHFt40kQ0R+tUj
 1JYlJ2KPDPDuC98dFzDbiXmblP8bpF8ZmQs260x+Y3xjKdz7pYkC0rXokKN2GEjraHH/
 DYfCI3wbFjAcWrxWAEUIJ/vEmhGsud+B8pnvlAG08Dna6qknAvhdRgPQjCswNz01eCao
 j0wENF8dOQS/E9u9XSfTCJzaa8KkmVCjK9reXcamgaZI290upn7CYcH+Ne1CsSytChq8
 a3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779932102; x=1780536902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KOAliQEKehOielf67P4GdnK3HfBj5fKy6QiXICQWLME=;
 b=Mp9c5FfTJx/oS/oxAhdM4tdG7mCgqPFyYDbMAJOPwNC1o6tYxJqGGdZK38XaWzYDXb
 0qWNdWEAcqDiuE2zf3jbR+UWe32eg/OdsG9RWtgRDhZTp6IxRM0VRSFqZ0if3hfDHOiP
 MQBg7jROQ2layb4+/FERpPQUIT+zzgCTla9EK7FKu9/ZpahIGLvMXTOf6t4NMD2R61sL
 QhgTS6GAXY4xBFrNgBZ3oyNlToXZsYSH9QQFVAvhg2926trVbWT6leK3QE4RQOmCopgb
 g2koTwrJicAgvGgLJZYZ3s2415e3nlxpO3DF+vgmxB+r4uY20gqUM0kn+jQeVzOBHLJP
 19Qg==
X-Gm-Message-State: AOJu0YwL1vx6d0cMiyyhAYH05A0B7BV9Xs5i6q1WT6ZgUoZwjJyynv1t
 DAzZjmBVm7UzJ9dyYm54iPF4AhnOi6LI/9PIRwGJGFq4Np++MUQoCEgklqkHP++6qPk=
X-Gm-Gg: Acq92OH8ozUjI5mW/XnWhe6MYF4xrmwKvFJjJK2weSoj7q3JfPS1e/W2ZC2wrFQyAr+
 MG33pjWtRYK1Tr9pqmbSrnH1bzzZSeFhlvCGfHzmtuP/sxYtz61cqUdrbIZcObuIZInM+/6ji0l
 csUox5ZoeRV99Lne757WHzTSqHG9oUC9rNrkurVLia9Z/hKhkiGTVPlMfxHTQRA2kmags8IJWRt
 ZPgB/lb/v9GJiuX1cQclHgx1i7NWHl1LqTHMRP29VAlkS/I4BzR+eav13l6MSCrSe2tVfEngpxp
 sM0qz2/HVl7mQrj236tcc+0zSexeoJ07yZ6Q3RHBHfFucGKzkdOxy31E0Fv8OTLSjzAM9Eld2Hb
 E4NWVBKbm9/jQmrk07Z2oGB+Xn8LxR4fwvpNbRd5SPBGs3v3GismK81lP9z2gP4Y1zbYL7RDGRt
 xjyuEQ6NKD123AQreWgl1TcWz7MT10vkrEPmo7UW5T43yM4cS0o8ytLAYRF2EIuCmi5Sjyaobzz
 Fmyk5aK89vi6N4VcKkkm8QjxjBe3A==
X-Received: by 2002:a05:622a:394:b0:516:de76:1d5b with SMTP id
 d75a77b69052e-516de76297amr313211381cf.32.1779932102091; 
 Wed, 27 May 2026 18:35:02 -0700 (PDT)
Received: from blam-mobile.hsd1.nh.comcast.net
 ([2601:188:c083:cd0:c107:2c35:5b4a:5cad])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5170c403529sm45723341cf.10.2026.05.27.18.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 18:35:01 -0700 (PDT)
From: Patrick Robb <patrickrobb1997@gmail.com>
To: abailey@iol.unh.edu
Cc: dev@dpdk.org, dmarx@iol.unh.edu, luca.vizzarro@arm.com, probb@iol.unh.edu,
 Patrick Robb <patrickrobb1997@gmail.com>
Subject: Re: [v1] dts: add default values for queue info
Date: Wed, 27 May 2026 21:34:46 -0400
Message-ID: <20260528013446.13210-1-patrickrobb1997@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260310184416.216482-1-abailey@iol.unh.edu>
References: <20260310184416.216482-1-abailey@iol.unh.edu>
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

Reviewed-by: Patrick Robb <patrickrobb1997@gmail.com>
