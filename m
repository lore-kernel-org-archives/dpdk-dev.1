Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17450C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 10:52:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F2B040156;
	Tue, 11 Feb 2025 11:52:00 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 867A440150
 for <dev@dpdk.org>; Tue, 11 Feb 2025 11:51:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739271118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lImk2rKsvBO28DOYxcZEL7BvS4JOszlM0v1shmMxKuU=;
 b=e2Zv9j6qzkIQf9hwozHyGcObPFTSUC3dpPCIwU9v69mr72HmlPF7bkqGZt6YSYI9ysUGS8
 Opassn3uOF+Du3+tSE9Lx+LE7YXKJ5ti/wTb9UBtG105kwWXzI4GdeOtVqtfgrOWP/aU5R
 PRmvK/SbsMmuM8KVRGn/I4ka8D2SHAE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-cnVXgPQ-No-p2YAwmgdY8g-1; Tue, 11 Feb 2025 05:51:57 -0500
X-MC-Unique: cnVXgPQ-No-p2YAwmgdY8g-1
X-Mimecast-MFC-AGG-ID: cnVXgPQ-No-p2YAwmgdY8g
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-308f2ec0f1dso8564691fa.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 02:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739271115; x=1739875915;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lImk2rKsvBO28DOYxcZEL7BvS4JOszlM0v1shmMxKuU=;
 b=dCq4V+K5xuheTi0wgcc8AsKoRPzhpIvVS4TnFAuoUIEgRYQ8Z0SAqCNgKDTytZ0Prt
 ZDZVXlmbWNgmyVZDB8Fad6g0GF51vzvII8KNVMHm9t1LWN1BV2h2kHmNOEupEd/NnJoG
 H+9ZnHoyC2TnR3ZYYuIKhjYU9UtJcnmftfA0G0+blp4LROr9UzSchU8R3xnD99PMvmLN
 JjT/ZXwZtgMGNSnCBGZ7Gzb2ShD7pgpcI61jR8qAC/WPkDcnG5AApZZ1qmDhHVKhYBOC
 g6JMUWmZKZwsNa4DVT3OeLxG6+1dKuuY0IYjYUa6uEljM2BnzrK32ShzPbgq2ZRcDRlK
 9H/g==
X-Gm-Message-State: AOJu0YxMQZ0EF/dfExuTMPS+v5KnooTuQ/NImFqMblBaXRyMef4gShWs
 I8BixNP9wXwlMK7zUj0MPc2o8/dXDCHnMlwZoFSePih4B9VsYTJsKWCPYTGEYLXH4yqpaMyWXVv
 BJk0w0oQfdviG+R9DgWWI2GCX4AdhfT3TmSTZXUIFHaj9s3mg/DsbH4MAbI5ZMAfj3LGuPbigfR
 gZYOt+GlixNhq3sNM=
X-Gm-Gg: ASbGncuwGuyJVINdi1klTH/aSb0AsD6wT+TosE0HMksfuBYEnRobwAHucK6wkdnBNoQ
 lmGh6hkYZZoMj4f/Zu0b3SbP08tmAX8ympwNnsG7iTGqyI4i+vaH3alHw3bvTdPY1
X-Received: by 2002:a05:651c:543:b0:308:f3f7:49bc with SMTP id
 38308e7fff4ca-308f3f74b07mr17723561fa.16.1739271114950; 
 Tue, 11 Feb 2025 02:51:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7330arjLSdelD2bK/+v3uycJ3+6tNByQQKu2bjuaWOZ2eKA2N+ZJZTm6DqH3kFidoX3dAeD5jvSxx1bXSAPQ=
X-Received: by 2002:a05:651c:543:b0:308:f3f7:49bc with SMTP id
 38308e7fff4ca-308f3f74b07mr17723471fa.16.1739271114531; Tue, 11 Feb 2025
 02:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20250205161823.2849595-1-bruce.richardson@intel.com>
 <20250210171845.1669874-1-bruce.richardson@intel.com>
In-Reply-To: <20250210171845.1669874-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 11 Feb 2025 11:51:43 +0100
X-Gm-Features: AWEUYZlZQJwBn5ycStleFct-e2jpprdJDpLyRK8HQVMazykm1ftRnsUF9npZS5g
Message-ID: <CAJFAV8zD-5bmnuYY11W+r513PwAhbcXsS4S=t2zn0yKpsjM-vg@mail.gmail.com>
Subject: Re: [PATCH v3] build: replace support for icc with icx
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>, 
 Ian Stokes <ian.stokes@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1dNm07Se2CaoLtO-Pk7sAxKzsy7Ns4krlogQF-xdmu0_1739271115
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

On Mon, Feb 10, 2025 at 6:19=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The "Intel C++ Compiler" (icc) has been replaced by the newer clang-based
> "Intel oneAPI DPC++/C++ Compiler" (icx) compiler.  DPDK compilation has
> also not been tested recently with the icc compiler, so let's remove doc
> and code references to icc, and any special macros or build support that
> was added for it. Document instead that icx can be used to compile DPDK.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Ian Stokes <ian.stokes@intel.com>
> ---
> v3:
> * separated out the icx build fixes, to revert to single-patch set.
>   Due to potential conflicts depending on order of apply of patches,
>   I will send these out separately to be applied to next-net-intel tree
>   rather than main tree.
> * more changes following feedback from David:
>   - removed cpu-endianness macros in testpmd
>   - removed unnecessary typecasts (and fixed line-break in err msg)

Dropped icc =3D auto() in dts/framework/config/test_run.py.

Applied, thanks Bruce.


--=20
David Marchand

