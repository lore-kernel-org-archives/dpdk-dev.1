Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EB6CD98F2
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 14:53:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED4D640150;
	Mon, 22 Jun 2026 16:53:29 +0200 (CEST)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id B146F40144
 for <dev@dpdk.org>; Mon, 22 Jun 2026 16:53:28 +0200 (CEST)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1384ebe7a10so3251519c88.1
 for <dev@dpdk.org>; Mon, 22 Jun 2026 07:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782140007;
 x=1782744807; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gt8OqIuCmTlWJdcKs2s8UBeTURaiBHStOWn2oMxePxs=;
 b=ObKj+EfC3SnB+18OJBEQk7zMED7YLrOEoujWbbgzWj+vi4iD/SrGzfWPmWmSqWmYjB
 3CNcBa0YkhrhNjdlHOLaErIWEYsJfWmoWQoZkk4Ra3A09qG3lWSZO+4vSWL80wfeYJgX
 +Ck7FFJlG/u4ei6XGsLDHLRflfY3xzoc/jmoQLcpA+ug+BFRzkJyELAGA+CgOliPuThn
 QZK6CjY4bEL2IO/imtGFm1hBLC+CTRfbBC+aUkpRjea6hj07U1iP95DZ3inv78MWc+8E
 3+zEPihkT10ApTZuJqa/lq9b1r0m3KYVwYPVQ95wh7eneHz7lrg4XT7rvePwk62jXNIP
 R5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782140007; x=1782744807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gt8OqIuCmTlWJdcKs2s8UBeTURaiBHStOWn2oMxePxs=;
 b=T5N9M2rWaZHAIiFj8dZPdqxzgetGP+/JTsn/AqFai7Ma4nMj/cIiBXVMSwIHovEs+o
 eCMAO1gFD9FvjJ61CEk1CCnwY8SVnVD39k1ibGet/B52HqhGpUuSa48SOcHdgoSVHCvc
 hpbwrqD7G4lMWgL+9lIPp0bqza1UlfDHIz2m+Qh1aL87HQA0o+CZ4iK0LpgeLW1pOGgW
 CtnRs+XeB0yJr0pBG8X/zP8ItoCgzfWzF5jNV3V7OtKFLhwFMfcAqG+QXHsUlwaxEmbp
 uq8KBgMYSLlLhbB6jt4URV71dALU2IiL5I4V/JtdrqD5GWZqcdWmP2IS71bwv78WQFf9
 CKwA==
X-Gm-Message-State: AOJu0YzJkVIJpswwJLoPHttv6j4kUAyopAS837GtLqV7YT3LamkMUVvl
 9OqFECYNW3ONIeaUBcJ059H8E10cKwS8mbk2Sr/Waoz1Isp2o2zrQdjH+RrMb2y4OU60HcSg+Lj
 4JNHt
X-Gm-Gg: AfdE7ck3ipUeaIuZ7fa/xmY/Mg+SoeYzWZll5agk/ZbvMaGsBch2+istve+7PT8AjPA
 o9kFVaV9dpzkFlvjW81Z+zPLuOdnipjL+g/9jno8G9Q8/bBkBlk/s/uWyHPMYBmqb1o+s53HkqB
 Fp8Sh0XjV7akWjnaP1M/ro/Uk+QK7ZmdW2BWikIKaLSeH1MOFozxm5mE4SSLGBW2wu1D7JdVcvq
 UqOBNSu2baVSJEegdKtWkTUvIfpKO+02wZcDstPTNUnRoTgAkEI6iofbnL+/ISGB7ocMeEa2fko
 u7eCzhRPZosFxhZBgeSLVJwTVRr+BHgeInThN+fWOf1SclFq7TS4OCyg064t9opXxLEwXoSQ1NX
 hCtpNVtK1FkGiHnUMpFQrMdWOZCKPr6NyhGNIk54bpiSgr0yDQrQLb1usaAzT+6ayIUG6gMZukf
 N71qlscOAR8FOWMIcBkN4oKGJhJeYZobZ5tjcJvo36nDlOLtQrpfFvSA==
X-Received: by 2002:a05:7022:20c:b0:138:37a4:fcc0 with SMTP id
 a92af1059eb24-139a4ecbd46mr9050335c88.12.1782140007205; 
 Mon, 22 Jun 2026 07:53:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139c2f622d1sm212757c88.7.2026.06.22.07.53.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:53:26 -0700 (PDT)
Date: Mon, 22 Jun 2026 07:53:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v8 12/21] net/txgbe: fix link stability for 25G NIC
Message-ID: <20260622075323.276cb2de@phoenix.local>
In-Reply-To: <006c01dd0237$9a737e60$cf5a7b20$@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-13-zaiyuwang@trustnetic.com>
 <20260617085355.0a87d7ee@phoenix.local>
 <006c01dd0237$9a737e60$cf5a7b20$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 22 Jun 2026 19:09:32 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> > > +void
> > > +set_fields_e56(unsigned int *src_data, unsigned int bit_high,
> > > +	       unsigned int bit_low, unsigned int set_value) {  
> > 
> > Function could be static here?  
> 
> Hi Stephen,
> Thanks for your time. This function is used in both txgbe_e56.c (for general PHY
> configuration) and txgbe_e56_bp.c (for backplane mode configuration). Therefore, making it
> static would not be feasible?
> I have also fixed the other issues you pointed out, including the spelling corrections,
> replacing tabs with spaces in log messages, and removing the term "master" from comments.
> 
> Best regards,
> Zaiyu


Why I noticed was that it is a global function not following naming conventions.
Either make it inline in a header or rename.
