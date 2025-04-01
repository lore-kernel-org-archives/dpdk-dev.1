Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A910CC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 19:04:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6996640150;
	Tue,  1 Apr 2025 21:04:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id CB920400EF
 for <dev@dpdk.org>; Tue,  1 Apr 2025 21:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743534293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+xzEolsTwYy6XK+5GHqWXxi2K2LeO9lvuYCbaCQpkI=;
 b=I5Y0eblxaLaaC0GLsJW2dXdOpue+HAujXeHOZA+5EBT/WJJRIgjJqfs5Az2kxbrCVQRxQB
 Lpoav+yse95E7S6VBael8uPHG3SE39bN4RHOnrN++0Knv7JS4CrRwET3Vn2rlSvuEu0fzw
 RRR/dFA7hKNX8JylMcHmV8GdUSngJBc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-_aT1f9qaPyiYR5EUHcs1Bw-1; Tue, 01 Apr 2025 15:04:42 -0400
X-MC-Unique: _aT1f9qaPyiYR5EUHcs1Bw-1
X-Mimecast-MFC-AGG-ID: _aT1f9qaPyiYR5EUHcs1Bw_1743534281
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-549948b27a7so2480915e87.3
 for <dev@dpdk.org>; Tue, 01 Apr 2025 12:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743534281; x=1744139081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+xzEolsTwYy6XK+5GHqWXxi2K2LeO9lvuYCbaCQpkI=;
 b=VeQqKFLj7psC4XuCOoPjkpBId1DT1m3Ws9oDQ1GjralTAWnM+ATktjlJRhcOZe8RLJ
 O2Y6UBdDBi6QVzkkSFMARKRuRiFKDCak+oXF1OwoYnEZBteH/2gKUIban7uZZ/pjGkKG
 nhLJmvN6m3sdSKnY4R+drjHV9jlUuhFG7db1TIlQEDWAP6cTM3GAPwSOqHidJDBnjmj4
 2c+atT2CsBMjmBq/DXOHjCk2alCTqochceVfSpLDWn03grybfbIyQOwZwSruWElVSmG1
 UmDUHfRtZ47TqJD5UeS9AiDWsAV96nMchRqoYtY1SHEzuP+ANPO0/L5WQlnSE2Pq03Wc
 prCA==
X-Gm-Message-State: AOJu0Yxh3RqRJ5CYjvbsgQ9L6+ueW7M8JkIFVIUUKuBAYcEX9iUEcQ/p
 xYzhDYgp1Dp2B6fwxn3/7wtiXgislWrAMJoCAojbpg9Tk366VdqiC5JxGffSaLReUPSlFsUbVtL
 ybdL/o/UVPcBUz5qECNAGS4sqd4qy1PnG3VLp0K82ir4828BcbXTxgQTiV7WwCevKSqc9bMpKFg
 PrNqWSKJY2m1UVIS8=
X-Gm-Gg: ASbGncsNjw0wmjLAwUdKccsz6nWWpMbO6gWUeTtCLSFPuJ7hQcUOsxfXyPJXyBJU4w/
 J2+IzaJKegG6XYp3gQg6nj3ApxwrhE8Fq5YdiqjqYV0GVMHKQk8uJe8mRdUqJ20G8yucN2aSytA
 4=
X-Received: by 2002:a05:651c:221e:b0:30b:f0fd:fd19 with SMTP id
 38308e7fff4ca-30de024b487mr45548081fa.16.1743534281067; 
 Tue, 01 Apr 2025 12:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcTunolPFeaShGbr5iKIbfNliXX8ZET+sGvpPBJBmdhbEitgINEjDwFHfFSG1B7wgewxp7KWCMTcJyFR7fVmU=
X-Received: by 2002:a05:651c:221e:b0:30b:f0fd:fd19 with SMTP id
 38308e7fff4ca-30de024b487mr45548041fa.16.1743534280713; Tue, 01 Apr 2025
 12:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-4-david.marchand@redhat.com>
 <19551467.geO5KgaWL5@thomas>
In-Reply-To: <19551467.geO5KgaWL5@thomas>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 1 Apr 2025 21:04:29 +0200
X-Gm-Features: AQ5f1Jo8nMCu0oBmRjAJvZ3ghW8p3TixZKDpqAdLHmTaJOCl6HPb4FXNS1TJKas
Message-ID: <CAJFAV8wgCaQOSabF3wUNyE6pocQVj_Pqhz+aXsrsE-C02KOggQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] buildtools: display version when listing symbols
To: Thomas Monjalon <thomas@monjalon.net>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cxxLQHfCcqzB9k9want5bS5Z_mFsKtcRbmBtlhJicHU_1743534281
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

On Tue, Apr 1, 2025 at 6:11=E2=80=AFPM Thomas Monjalon <thomas@monjalon.net=
> wrote:
>
> 28/03/2025 11:52, David Marchand:
> > Display the version when a symbol was introduced.
> > This is needed for scripting the conversion from static to dynamically
> > generated version maps.
> > It is also useful when listing experimental symbols.
>
> I feel the title needs a bit more context, maybe adding "map"?
> buildtools: display version when listing symbols from map
> buildtools: display symbols version from map

The second form lgtm.


> Do we still need this script after this series?

It is still used in check-symbols.sh, to catch symbols present in
binaries that are not marked as experimental / internal.
I don't think there is a way to replace this check.


> Should we remove some scripts?

I tried to remove as many as I could, but maybe I overlooked some.


--=20
David Marchand

