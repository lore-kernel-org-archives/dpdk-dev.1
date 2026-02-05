Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC9CE91269
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 06:53:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2EB904026D;
	Thu,  5 Feb 2026 07:53:57 +0100 (CET)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48]) by mails.dpdk.org (Postfix) with ESMTP id 6240B40264
 for <dev@dpdk.org>; Thu,  5 Feb 2026 07:53:55 +0100 (CET)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-5f524301a76so1191332137.1
 for <dev@dpdk.org>; Wed, 04 Feb 2026 22:53:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770274434; cv=none;
 d=google.com; s=arc-20240605;
 b=BbpU+MLXNZQvKFSOtt3j1J3GftFpLzSsKrhroZOg2P92KhDQiLk2fMsMae+Og/loWp
 IppQShKWl3+VUHPvizNcp/xHGo1shvkyxTSQcT7ty48NIrhfRPVq/md7sghM98CS/H5U
 xxYqRh/0VvjEqlZIhXL8re+h/NNUKU5fRQ//LqfImCb/biGnJkoTcEOaK3lpIMgW8eMQ
 K0LJ8PY062JwjGbuhqAHJsQq2OYpYBIyuvxcTzdxs8njZTqN9knQIloRoM84rXQ1RW3k
 c/vsRv++CpceucHAOOW26WhmW4lyMQNOeqynptOPjcCfbcrgBVhuWxlDapyUlN/CtYKf
 8H6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GPCIn8zhKm2B/IXpF01CMTH9phq5aCx2eHPm3TA3mUE=;
 fh=7hGAxMJ0ahU9WdmcbH8esh2qqgZqbutD5AFuMCFFoQY=;
 b=NVeomS/mV9Nhv36jvWYIQl7iAIFX2hswK8IPgB37jplRG2k+BLpcXpuO99GToI12SU
 txkPuh9T4uXg8Rx4fBrN5Huam8nySKBTqsbJK6Qq7rXZcqp8YPoSHWPvTm8m5Twj7nKa
 5T5Jc3wPQnBZ6EeOJvPTdrOOe/KBK22RsCM8IZ3cTQE+PapO8ZWcG1RozaiAa1cqKOWj
 0ebB30te5Q8so/SjEATOA0BChbSml+gM2hkHmoifj8RlQITgCFsCz01G2MNdMJcXcMUu
 UBKsvlNblVY6NIxHQiK7t+Z4ZoydYMdr2k/K87PJm82xLAc3k6HVgDJmCJZYWKRMIZRi
 dmvw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770274434; x=1770879234; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPCIn8zhKm2B/IXpF01CMTH9phq5aCx2eHPm3TA3mUE=;
 b=Ouq56LLli2feB2MHY7CENa8LYUwPddjgobV6CJnDF8cNIsiLBrlWuOg5lBuucbyyEy
 am6hdtV9PcqovbKk+bgqdi496i+Uuw5PxeQDSZu4cnRCfYJIwaABETNIIUgeYedo92GK
 GInZnqDzV+l/c2ZsE2IeVN3H6mqqDD6vYwkMsh0dh9RzPY4dk8ZPod6ofBDD90xsG5Eu
 sg1LTxCcvdGBtpmYWE2SpA1+t1Ay4+LIrNhhW8TCbEb66IZmbV/uwo2S9Om6iypKWime
 IkJ1fcQ8AosxCpNMDwsEzthGzUK9YfhH73h+YfdsYNMNB4np8335n/gR37/aM8hu+/km
 BdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770274434; x=1770879234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GPCIn8zhKm2B/IXpF01CMTH9phq5aCx2eHPm3TA3mUE=;
 b=AKZn0niZLNBaNeef3/S5Fd/XohWkvcYuntoSQUaBs82BOSAN8os+wCaKeCdbyEo7TL
 xUgKpvYMYTaRtAlBPUditUJ9+mQiRD6FGo86oIHCcD91pyMEJ0Ev0pYgiSeJgFUzYHOG
 54c+xDC+yYIx6ALjt8C8ltsCY0iiM3x43PcGeouhNAYB/GWajW8NPTTXmdUe0q5fGjex
 nZnoznF/JMAwj0+uVQqUfX+/S1rz21n4SzggDH+F4lYscH6xBUD2Zz8u0SRfkOqVphYI
 tmk+9ruBFdY9vwclAKU4P9cmz8+LwbL2THuiguuftZ6bVqwDVXJdKbXNNUGoSMaYsfAW
 5vXQ==
X-Gm-Message-State: AOJu0Yz7mCxHzwuQcFIwsmKxPIV24pVBmrXBiLaxN5vCL5j9BRuYQUuC
 udti5S3Tg72/ualqK9/dnTR19C8oV0UhC/gz1VLXQqolq4JlFT/SAvN3LkuenhjU8rdfFqXSwq5
 tnLEWD+n7t9pJ8WAl+7wY9XzVuZ6ssMY=
X-Gm-Gg: AZuq6aKXr87Q95r8wUqF3TPO01yVUooFS/sUzl7xJtGkw1VkiSvuXtGt5avY+9F+1mZ
 9nGdFLei7wEt7UafmzacKC6WyaK9+fciET4dpvjvA5mZNIJ+llETIKtuC3Y9gQMRy/sGC6KsdSZ
 X5Sh/n36SR4NRCWHra7bgOaKPwZZykGAKLfuLwC2AGpuB0ux/J4cRZ95wwQqpLKRfg379AbfC9W
 JgGWC/GyXrIMm/oc+BgeyY/KXCkQU9P/7eWMm6N6N6ngamZhEnn1UAN/miqW7jRFdJKIJZvkQfo
 6nsnOQ==
X-Received: by 2002:a05:6102:291e:b0:5f8:e41e:e5cc with SMTP id
 ada2fe7eead31-5f94d4d2d32mr580545137.9.1770274434482; Wed, 04 Feb 2026
 22:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20260204024631.73059-1-scott.k.mitch1@gmail.com>
 <20260204061234.25610-1-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F656ED@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F656ED@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Wed, 4 Feb 2026 22:53:43 -0800
X-Gm-Features: AZwV_QgHYmRrdqEU8_zIbpiKs8THD0qxmPlCSxC_PJP58PlPOqu6KOZoXDMZxTs
Message-ID: <CAFn2buAqwDuQnXFiVk2P=94FdDprsfhOvG03hFmvi3-LoW1UiA@mail.gmail.com>
Subject: Re: [PATCH v20] eal: RTE_PTR_ADD/SUB API improvements
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, bruce.richardson@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

> Clarify (for dummies):
> "Use of RTE_PTR_ALIGN [...]
> + with integer types
> should use [...]"

I'll add a new line to be more explicit.

> > +#define PLT_PTR_UNQUAL                RTE_PTR_UNQUAL
>
> The PLT_PTR_UNQUAL macro is only used in drivers/common/cnxk/roc_cpt_debu=
g.c; but I think it can be avoided by changing the frag_info variable from =
"struct cpt_frag_info_s *frag_info;" to "const struct cpt_frag_info_s *frag=
_info;". Then you don't need to add the PLT_PTR_UNQUAL macro.

Done.

> > +#define PLT_INT_PTR(intptr)   ((void *)(uintptr_t)(intptr))
>
> Like I didn't like the RTE_INT_PTR macros, I also don't like the PLT_INT_=
PTR() macro. Please get rid of it.
> If an address variable is uintptr_t type, can't you cast it to void* and =
still use PLT_PTR_ADD()?

Done.

> Is using RTE_PTR_DIFF required here? Or can the code be unchanged?

Good catch, I will fix this and review RTE_PTR_DIFF usage.

RTE_PTR_ALIGN_CEIL is losing the ptr argument type by going through
RTE_PTR_ADD, so it results "error: invalid operands to binary - (have
=E2=80=98void *=E2=80=99 and =E2=80=98char *=E2=80=99)". I will fix the PTR=
_ALIGN macros to preserve
return type consistently and also avoid void* cast which may impact
optimizations that are alignment aware (required by RTE_PTR_[ADD|SUB]
bcz result isn't known to be aligned).

> > +     if (addr)
>
> Correction: if (addr !=3D NULL)
>
> > +             munmap(RTE_PTR_ALIGN_FLOOR(addr, page_size), page_size);

Done.

> Do we also need __rte_assume(ext_mem->buf_ptr !=3D NULL) for when buildin=
g without RTE_ENABLE_ASSERT?
> If so, remember any other RTE_ASSERT()s ensuring non-NULL for RTE_PTR_ADD=
().

Sounds good, will do.
