Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03858D2503F
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 07:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C59BD40288;
	Mon, 12 Jan 2026 08:58:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id F286E4013F
 for <dev@dpdk.org>; Mon, 12 Jan 2026 08:58:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768204737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q1A5KlktpdoNrAKG3u7rmMX3ThyuH1/hkv7v5pocO+c=;
 b=CwXt2M38a3RyQ09AKXUHq79bsltliPF0uo0HGsASJkGQuuHrSEMnBwowK92zqEA357YOA0
 RO/fbohxzFdNMA342FroU15Kba/y1nqG35GoSCA1qtTQigg55fNFERAXa3zvoAMiywFAg8
 Y7Y6DaZaV/ttvclDdz/C47imDCpT+n0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ar83FCzdPm2XcbRepm9R3Q-1; Mon, 12 Jan 2026 02:58:55 -0500
X-MC-Unique: ar83FCzdPm2XcbRepm9R3Q-1
X-Mimecast-MFC-AGG-ID: ar83FCzdPm2XcbRepm9R3Q_1768204734
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-59b6fb01675so5650649e87.2
 for <dev@dpdk.org>; Sun, 11 Jan 2026 23:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768204734; x=1768809534;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1A5KlktpdoNrAKG3u7rmMX3ThyuH1/hkv7v5pocO+c=;
 b=jdV8rH2k4+WUXUazWqjlCxyyPmLMLgJm9PhgPAMay/lGML4VzJw5x/0gmapHEE5wvF
 EOS8Gv4W84ruT3mMrOTKM/OQfOaGLVdLvRCDE4eqcbd5XWOdI3ho6VYqofLNQ2f4oz6j
 qKZZxNZGmoH/xgWzOTtvyKJv4dxqyyEuDbilbDQf1lcpUIeF2Cp7e+EYfdmN1Cuqv7Tj
 auTcQpgcVbV4NM5lqCcelJytJW+pwLMW2noP30ZOCKRFnLXhmBkyBxDLflZ9SIFQhVWT
 7MFOrRpe9IeLRpaDD8mggzNCQeVkeVca6mLqK9HXBS8aBA4yp8Y8umTldrPrMT80mUuh
 5jLw==
X-Gm-Message-State: AOJu0YwW1lSa0aSrqIimnyVu5N/2W2J3AGuRkZ/HFydHGI934vGyPCze
 rvjLocNvFA6BXD5cDlLI8FNE1zue37Dg+brxy8E3B1YYhZH484EmJg4MkyWDWDtJw4oZqd9SKOh
 Oc49hoeW1w7MBldaHxmmsKKBFSVebbR2Z4pwfKOuDXs5ykGse8CRyaHIc+Ol/EpxsmvfzY6M9W2
 aVszA7tFOrALY7CrOfGd0=
X-Gm-Gg: AY/fxX7Z/XKGRTEaMZK+h2fdDHAxzlHFSMVDJ1UjibJp97iX4hLL95H9JtwsDsnK5Yz
 tSCR7fAPWPWYURaYnc+s38YKVn172MJVkGr17chAyEvDJLmxV196p74bddv7Yk701f4tpIOF8za
 IrlVDF4tgGHcOWZ3Mw2lLR/tfTQR/6m7kujxON3n9pn5JFoUz+hacTB7iv1dc93e3mKBhF
X-Received: by 2002:a05:6512:3d08:b0:595:9d6b:1178 with SMTP id
 2adb3069b0e04-59b6f048a3emr5837427e87.40.1768204734234; 
 Sun, 11 Jan 2026 23:58:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH149JquUcnokgn5nXZAzYgBOEECbUJ2xeAwkyNMebxquwQOsFY2gx1P8T7akiIXQNpA9AsKXLoQw4VaGYYPyU=
X-Received: by 2002:a05:6512:3d08:b0:595:9d6b:1178 with SMTP id
 2adb3069b0e04-59b6f048a3emr5837416e87.40.1768204733845; Sun, 11 Jan 2026
 23:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20260105125441.50447-1-david.marchand@redhat.com>
 <20260111170350.6fa88e03@phoenix.local>
In-Reply-To: <20260111170350.6fa88e03@phoenix.local>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 12 Jan 2026 08:58:42 +0100
X-Gm-Features: AZwV_Qg8_iP70SRd-FdAPdFVuG9zFkYUfiaxXGH8GDGQOZ38sPUTbUB4u__8GBE
Message-ID: <CAJFAV8yvx_eLo9_wBDrzW-G+qiUYftGC1xUdAT6bLeCTVaxcoA@mail.gmail.com>
Subject: Re: [PATCH] net/af_xdp: fix external mbuf transmit
To: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stable@dpdk.org, Ciara Loftus <ciara.loftus@intel.com>, 
 Maryam Tahhan <mtahhan@redhat.com>, Xiaolong Ye <xiaolong.ye@intel.com>, 
 Kevin Laatz <kevin.laatz@intel.com>, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lp49xguZWVpBkhmiaorEFDkz8kLIJAvJlNvOU2d-JOU_1768204734
X-Mimecast-Originator: redhat.com
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

Hello,

On Mon, 12 Jan 2026 at 02:04, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> #### Warning (Minor)
>
> **Implicit boolean comparison:** The `RTE_MBUF_DIRECT(mbuf)` macro returns an integer-like value (0 or non-zero). Per DPDK guidelines, explicit comparison with zero is preferred for integers:
>
> ```c
> // Suggested (strict interpretation):
> if (RTE_MBUF_DIRECT(mbuf) != 0 && mbuf->pool == umem->mb_pool) {
> ```
>
> However, this macro is semantically boolean and is commonly used in direct form throughout DPDK. This is a stylistic preference, not a blocking issue.

All callers in DPDK are using this macro as a boolean, and I found no
opensource project doing differently.
I would either fix the macro or change nothing at all.


-- 
David Marchand

