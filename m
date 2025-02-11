Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD73C0219D
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 11:06:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B13DD402B1;
	Tue, 11 Feb 2025 12:06:17 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id AF0B540156
 for <dev@dpdk.org>; Tue, 11 Feb 2025 12:06:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739271976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mz8S++K8liqqvXomcOQFq997LHuqNUa1q7mQvc3b7tk=;
 b=NmDCYEnjqTM/me7L8710YoVcpNR+CisPRyvfOyMgRjVn9OLvtIAcIBqvZmSBAGHI70KA6x
 JcNFnHtSD9mf5vd/6jZNo+g5VQVKBc6Fpl6YzEQsra6JlY/Z1OKBvWKbV9opmSakxUb9gg
 6BdMziOdKzVB8RqP9Wsd+T9wuSjEOCA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-SAbz3L21PLKUzAqRQTAQlQ-1; Tue, 11 Feb 2025 06:06:14 -0500
X-MC-Unique: SAbz3L21PLKUzAqRQTAQlQ-1
X-Mimecast-MFC-AGG-ID: SAbz3L21PLKUzAqRQTAQlQ
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-308f17d4dffso8042891fa.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 03:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739271973; x=1739876773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mz8S++K8liqqvXomcOQFq997LHuqNUa1q7mQvc3b7tk=;
 b=fFYJ8VQVTNXPcbE26qceue4687UBkZtvsjoWAId7HgyNXw2PsB3aWW/+Xr/9UuXKkP
 XyLHPRWLy+IWDFnwJlZXOitLPy2ipO/1E8siBnl2FcCLO34ZDDrOWlD87q9EslELge3U
 HwHP0daG1gO2RwO7HZeuF4bjuM5tRzrh80g9UrdLz/8Y0+bzQWaNQI8EXiLhVYIOEouT
 SEZxiHdCQISdm531fU2r2fGKbxUZJA6SNHDr8BfROrwZh+5cjx9gk0RquqZGFjHq766f
 DkLoXWwgBXIiC8LS7bbEnp/meDtEg/finZ4BVMZKL3FDDmIkkPYuX+9rwyWJnocLWY1a
 rciA==
X-Gm-Message-State: AOJu0Yxcuhh6BYHsq9eukzKW9BDibqRMnvzc5Ysse+pNS7U4ZGziyN32
 uZ+5kYlvXrlrXgGFatgaXawMa6rQ6XF8zvIh4/eyE9Au0UVI4cATLqQkjArN2M/5Ud5hqqJDLYw
 YaxojvsFSn6BfOVRlJOnS+MNpUnGCota9GC72deeai2PUFNr88LXFHI7CqikzyNMi5occLY15+r
 K6hnw+0jf8WOb9ybI=
X-Gm-Gg: ASbGncv1YRqVaNaEgGqxEyXmOYQV/9q0UMuEwlAhIvWWGjWhJ4kwRNxeA6nHcvZFgOW
 Wo1N7te2OFAxHx4yo/TiEgdyj66ONua+xFz3D3eOlJOJrGgcGhgmXxuoLbZYvPLlD
X-Received: by 2002:a05:651c:12c3:b0:300:43cd:3b18 with SMTP id
 38308e7fff4ca-307e5a8dc33mr45661891fa.36.1739271973255; 
 Tue, 11 Feb 2025 03:06:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmrAV590+Xls2lZUumt44DmveBqymGKdj3JD/+8sAoH0vO7+Y+dk3htnR2iYECLw6BYu7ahxSe3K7HCpSKguw=
X-Received: by 2002:a05:651c:12c3:b0:300:43cd:3b18 with SMTP id
 38308e7fff4ca-307e5a8dc33mr45661811fa.36.1739271972893; Tue, 11 Feb 2025
 03:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20250123172048.134417-1-stephen@networkplumber.org>
 <20250124182647.117636-2-stephen@networkplumber.org>
In-Reply-To: <20250124182647.117636-2-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Feb 2025 12:06:00 +0100
X-Gm-Features: AWEUYZmEM56abdnEhvCcKU7Sz85yF8ZMLcOIEbU42VT4DImHLeqTzQ_ZscgE2VQ
Message-ID: <CAJFAV8wa+xe=7vXNoaZH+Kk9i-KvZd-3SpOgkdMsbOn7Wt+ECg@mail.gmail.com>
Subject: Re: [PATCH v2] build: force gcc to initialize padding bits
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zS6oGbC3oeVE0s20YDqa94F2iejfSXX-bm1n9SY0Q_Q_1739271973
X-Mimecast-Originator: redhat.com
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

On Fri, Jan 24, 2025 at 7:27=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> With GCC 15, the compiler has changed the default behavior when
> initialization is used for aggregate variables. The new default
> is to follow the standard (C23) and not initialize everything by
> default. This breaks assumptions in some drivers and can be
> lead to other bugs. Use the new zero initialization flag to
> force of all fields to zero.
>
> Note: other compilers always initialize to zero in these cases.
> Only GCC seems to have decided to start initializing less as
> a silly attempt at optimization.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>

Applied, thanks.


--=20
David Marchand

