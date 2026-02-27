Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8ECFEFB6E
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 16:18:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A3B6402EE;
	Fri, 27 Feb 2026 17:18:41 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 1977B402C5
 for <dev@dpdk.org>; Fri, 27 Feb 2026 17:18:40 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12758ce1e8dso216866c88.0
 for <dev@dpdk.org>; Fri, 27 Feb 2026 08:18:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772209119; cv=none;
 d=google.com; s=arc-20240605;
 b=HZ8nG9fwPnDCTeocM6QshufkXPZMbobhfzdmR43ibGzdDooI7pAXY/khrv7gVBVjZR
 cPgbxak9UXtyoudhyGErIY8abKs8o8HGl4Gg8LV/Ysf+j/ESuX+g/PfcuQsgfkkvIHYJ
 qysmfuYAxnV3uXKDPzSGh4aru2gfW9SZh/s6e8eSURDk3Pfg9gWYaQ4/1TJW3GKKxk1c
 X7qsrDw3THJPYtC98I1R9H51QUH4voW1ME4QgWa06apswajsQhb/NvJ029QadP3TmdGK
 DvlW2cgfI9RRI0AoZT4yLstGGNf+eVj5EXypt+S2wCwcWGTIPxtFphNIIfSxzb/9IxLr
 F3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LPvTSfUE0ZSolnJwusGkhvVQzd+p1u2iT/ZMgrgBv84=;
 fh=X7aNcsMm0sLXJF4N/ciYqZbHDbDCjfyQVAe9ypZQHIk=;
 b=BXPo9pnjqsltwog5GS4zBznYJHjoGOz6XKOrd3ALIsGUOaFpPJa2f+GAQIjcxxCefV
 lawiul7xUeDXyY3PgzdNzP66LoKv9WJvk/KI5q1LP+xDWHhuUnIroGU/+Y0F/b/V9Iaf
 TTgYRus1m+0CWQmC0mOdO1KThDvuDVBfTQqU+9q3GH53bnCmtHRic5V2vbXJU5HOGDvx
 khQmlqg47UTC4YyW1olj+aNRE2ySui+3FwtSbwxCUivRx1+nXW0doOiRCBjPd+jFtGIG
 XAvUzdWh6m0Mwvjw6Ln8PBzXGSj1kgqQRszhtf7I2oj3P4Kf4FgmVeVd4MxdBZ6gJaph
 L1+A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772209119; x=1772813919; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LPvTSfUE0ZSolnJwusGkhvVQzd+p1u2iT/ZMgrgBv84=;
 b=eU9P5tjfNfGfcwRkk4JMA7/DwIOe5G5OWVsBwWAOBJsEEdZPXZbF/no1o72ypsNca8
 Qkik527T8hC60XmRbG1fd8SBYNhNKeR8K3kw3Bszp3p+AZw03GCKdscn8GyrHiTPs4c/
 J6SbOQy+Rp2JFp5zwTS5vxyt8Ib4qI2TT0XTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772209119; x=1772813919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPvTSfUE0ZSolnJwusGkhvVQzd+p1u2iT/ZMgrgBv84=;
 b=ee1b0ioQ3gC9HIKzRh+8qDhIQu7fN3l4DApSxxAc14cVu4fd5oFQ2DFTXkp/psp7NU
 L+3yzu5KvDk1/vpPoZRwhfBDyzVXNRPKzq+EvtmTUtUDMZbQWzWaVfngEiKdg4kEWtfO
 g9UfVu1OP2m+PkMmIYqelPCLUj/ww6+U877cJ249iO0mPognx8/D+Lcvcjzr7I+2sQ/A
 Zcvst6lHPMswSdrWhhUgCWBYwebuOGit+031kmTroiwQgPOtpuezk+YHzLK5RoaXDVsw
 ZSEu1UBP+/+Fy0ci7xB+WBAKUTZAFqMrBAt7V4VN85/4mylpYDtQlgjt9xE2GqH1GCig
 Sxsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ6FB9AqJYHtjccE06anFs16y9iXl7xnBguqFFjnYHE/8mkFHrtGqRM0MEraf7KCquknc=@dpdk.org
X-Gm-Message-State: AOJu0Yw4azkweo8+H8mSLIghwiw+g9knbUZG86zJyTKbUvcWGt9VtPBw
 XPyBY1n6lyVNRpVr+L22qQ9oXPuyppdHPBZFnkWwYZ8RPvDCQasjD9FA/X5UIzzFKD9j1Gq2Miz
 ymp4deQpdfdmWbzCWyOnmx3ECG8VE3VeU9v7pG81mkQ==
X-Gm-Gg: ATEYQzzOEJ+V0I4yonfUxBfxuV4uy/nwqBpuujMCtXPzLcNNwib2Kctu3xro+hVkX34
 uTXJcne+zicxncq00Ykzra5FUWUKpGWZxtveis2GwEh6IL8o1i02t431SPZCw9W3zgDC71qL50E
 HXsllbC6m+P52U//rp2i0wxHgsALsqh1Ur6bjWMhZhDyT6OR45bzjcTHMmgIlsuoHkQQi5tiZty
 abKpo20tyk3U72KCnd2ITtoMg1SwVktTowOQI1ouaCdNM43GrHyXYVBIFEcUKAiO+ApHF2JZDFY
 3WIQNvTyfoqjShgD7ZzGTeNcJLFxJy2pwe7V5YGUBc6om7yvCcduYnsAbFYsMWsWYOlOQxhNIqj
 mjCNWESk=
X-Received: by 2002:a05:7022:928:b0:11e:163:be60 with SMTP id
 a92af1059eb24-1278fd591f8mr1466000c88.31.1772209118831; Fri, 27 Feb 2026
 08:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
 <20260213193539.103858-3-abailey@iol.unh.edu>
In-Reply-To: <20260213193539.103858-3-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 27 Feb 2026 11:15:47 -0500
X-Gm-Features: AaiRm50jAqhhCoVNlzUzoivmX4dHMApd-8yKaAK-VYOm-E3vk9X_PrI1m8pzHfI
Message-ID: <CAJvnSUAKrs9vmZ16vH511kUWB+MrXJLpGK-kPTnQ_KANywcrbg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dts: add cryptodev package to DTS
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

> +  # cryptodevs: # optional; add each physical bdf as its own element in the list
> +  #   - name: cryptodev-0
> +  #     pci: "ffff:ff:ff.f"
> +  #     os_driver_for_dpdk: vfio-pci # OS driver that DPDK will use
> +  #     os_driver: _ # This is unused but a value is necessary to run dts
> +  # crypto_driver: # the device type of the DUT (crypto_qat, crypto_zuc, crypto_aesni_mb)

This naming is confusing. Can you switch to crypto_device_type? And
push that naming update downwards i.e. into node.py etc. Also, how can
users know where to find the full list of valid crypto_device_type
fields?
