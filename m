Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2053CC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 10:45:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5201F427DC;
	Fri,  7 Feb 2025 11:45:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 05ED9427D0
 for <dev@dpdk.org>; Fri,  7 Feb 2025 11:45:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738925124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjRoaJh/a495Msku+1ZaaoFL5KYM3fC4IVnDTZXUI9A=;
 b=e9exPEzoP2G/JhLyv9FzCliTlzjkYyDBBXV1dI7+TNv9vfP5RL2lfmpFPRfbHli4wzYkCf
 X2terVaMcuzE+gNcW4pjYLoLsTSz1cg4KqC+HX5cxGGO/lEtqLlBZgw14tHRxXn9Mm/SDI
 Na8kagfng7svDDKs6BPT08R8eJmnDT0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-FLp8-yEBPHukXi6IIyNDrw-1; Fri, 07 Feb 2025 05:45:23 -0500
X-MC-Unique: FLp8-yEBPHukXi6IIyNDrw-1
X-Mimecast-MFC-AGG-ID: FLp8-yEBPHukXi6IIyNDrw
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-544fe4c948cso153869e87.3
 for <dev@dpdk.org>; Fri, 07 Feb 2025 02:45:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738925121; x=1739529921;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjRoaJh/a495Msku+1ZaaoFL5KYM3fC4IVnDTZXUI9A=;
 b=AQZGp7eQYkntEYg4/fm4AnoSePjbdRocSV5apMUbdfJcKa625r6cZRqDK5uLVQy8HU
 0VnPmKJGINMDtLKOpxR5ZWChvToaelyxjkvMI6VXkMOizPj0imftnCsEuyBf57o57WzV
 PBpzG7RtJ30kC1nys7420mwXOrlH/FDGD0BrT5WLs2lRr8AzCfYHEWj7St3tC1SJ56IY
 EIp4kIDGz77yuYMM3ZCKzQI6pTKJI4M4Q/+WiIkwI++dzVJKdaE08tY7z04vWt8W0IKS
 QkFHPCElm6Jzh/0jFrSA5hSlb5odG0b7FehTVeA9IHTYzS35jY7qTuOSYVKEEFbBYBVa
 /6zQ==
X-Gm-Message-State: AOJu0YxVo0Ba6XQBaaNimlJRqGBPt+bfeVIisFJFeyYmtm78jeW+aPB4
 v59CarqN+SuR4n4mlaJJ6Lh/blrHyXsa6A8rf+IQ6uYzPQSIq+VBiRKhBa3wuTlatw4L9Ei07w5
 RR3LD/BJdXGfR/64PUNPD1ePBG/8mDKSwB7Q06XVQnDEfXsb5aiiv0Bmb6S2WHouwEh/BNSSk0n
 W/UGqTV8QnUrxvXpXXpJr9g1o=
X-Gm-Gg: ASbGnctnif4YEYhOZItLoIjE4oAMKpD6MaeN5y+f0B/i8Rk2QEAN2MkEGVlJdG6ELoy
 Ch5qjwLLVUTX7NIMz77ywVDabcKWmWO0bL1AT6rsPPlO0CGdCQg1YWkDkuuQnRcuT
X-Received: by 2002:a05:6512:3d2a:b0:542:9883:24c with SMTP id
 2adb3069b0e04-54414aba945mr872092e87.31.1738925121541; 
 Fri, 07 Feb 2025 02:45:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuLyQG590W9BVsYBf7N+dBUy96MhICU2jI5acDdhqBmalEEvGMWM6fWIQPXRmZChkMdg80HBnSQRUknWfyDKk=
X-Received: by 2002:a05:6512:3d2a:b0:542:9883:24c with SMTP id
 2adb3069b0e04-54414aba945mr872079e87.31.1738925121099; Fri, 07 Feb 2025
 02:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20241202125316.3732529-1-david.marchand@redhat.com>
 <20241212160049.1258449-1-david.marchand@redhat.com>
In-Reply-To: <20241212160049.1258449-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 7 Feb 2025 11:45:09 +0100
X-Gm-Features: AWEUYZkh3a2UJQHd5H-wLvJvfJ0IkUiG0IY7oqNAMNkDiDB_YKxwJg-BDrBExw0
Message-ID: <CAJFAV8zA_d3MzcfyHxfsDzZXAxF3XGfZicuZew+EoTfemeB20w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Improve lock annotations
To: dev@dpdk.org
Cc: thomas@monjalon.net
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vkJkVR_Fuxzi53diNLJLNE6J6ROMY3GRklLdixxFEJQ_1738925122
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

On Thu, Dec 12, 2024 at 5:02=E2=80=AFPM David Marchand
<david.marchand@redhat.com> wrote:
>
> A recent bug (see 22aa9a9c7099 ("vhost: fix deadlock in Rx async path"))
> made more visible a gap in the clang thread safety annotations that
> DPDK uses: no distinction is made between releasing a read lock and
> releasing a write lock.
>
> Clang 3.6 and later offers improved thread safety checks.
>
> Marking objects as "lockable" has evolved into flagging some named
> "capability". clang reports the capability name when an error is
> reported (making this report a bit easier to understand).
>
> For example, a spinlock is now flagged as:
> typedef struct __rte_capability("spinlock") {
>   volatile RTE_ATOMIC(int) locked;
> } rte_spinlock_t;
>
>
> For "exclusive" locking (spinlocks / write locks), the conversion is:
> - exclusive_lock_function -> acquire_capability
> - exclusive_trylock_function -> try_acquire_capability
> - unlock_function -> release_capability
> ...
>
> For "shared" locking (read locks):
> - shared_lock_function -> acquire_shared_capability
> - shared_trylock_function -> try_acquire_shared_capability
> - unlock_function -> release_shared_capability
> ...
>
>
> This series proposes to use those annotations (sticking to the
> convention of simply prefixing the compiler attributes with __rte_).
> The existing "old" annotations macros are left in place in case users
> started to rely on them.
>
> Note: DPDK requirements state that clang version must be >=3D 3.6
> (following use of C11 standard).

Series applied, thanks.


--=20
David Marchand

