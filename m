Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB97C369A6
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Apr 2025 09:46:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F72940669;
	Thu, 10 Apr 2025 11:46:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D38A0402ED
 for <dev@dpdk.org>; Thu, 10 Apr 2025 11:46:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744278361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1MpxgbMf250GU138iuKLj3iNAOOc3wy+FC9b5vRX2f8=;
 b=T9eKITFsqYbRh2WRAdHxJZfx7txGr4Ot0Ssi369vRt2Mj5hONeivBsFxq1q4ELD/IlF7b/
 gdva9zQmusMj+lz9t/lfeblTUE7Mt2GC6jZsGZW7QVJx7PmYAxcm0VBio3QarZCktCMUfV
 qK0ylYlf4cZQvwB3hiEW79wf+3JgTNE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-Cwi7iWl_PpSATv21KZz8Ng-1; Thu, 10 Apr 2025 05:45:59 -0400
X-MC-Unique: Cwi7iWl_PpSATv21KZz8Ng-1
X-Mimecast-MFC-AGG-ID: Cwi7iWl_PpSATv21KZz8Ng_1744278358
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-30d8365667cso3835211fa.1
 for <dev@dpdk.org>; Thu, 10 Apr 2025 02:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744278358; x=1744883158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MpxgbMf250GU138iuKLj3iNAOOc3wy+FC9b5vRX2f8=;
 b=cQMz1Cpz9JXu/zARwyAgYx9UI7gjPj3vNyCXvpQA/YtUOy0Efe3YloND8JrB2q1hOk
 AMJLDI50BV1DBqtAewHdtMkI0SsYGlgezywuMIVYZ/ISY8dBv90eYY3cYkhPu0+3OCgs
 wwfissUArp+mfw/nxrDEhWIZhQWc/iKRCJBrK0xvxOxam4Rry/uTWdkwPThgBmgO5KuA
 kduJQSuemHq2aef1fhW/3dwi9vI5GmQjBz1qJOGmitBxS7FcBtydGhxc6cphQO7x4Ok3
 ZVV35QExjHZbYpgQtkZsOGD+/uzznkdfjNx9llzL7c3bsJp/2tkRMdysROBHY7cPeRQe
 PkQQ==
X-Gm-Message-State: AOJu0Yxgn1BK2s6ye4TuPdE/BArK0UhsdYuWrmmsbr0huAMjFUJdAuWf
 x7KMrmI/sP+D+7OB/IV+KVXs7XoQDRxSjba9FYXUh2RWUAZvIQ3wizMVsd4wTJiRRChq2dUjj14
 6g6PbWIodmiqPh+i3+kAfDWbrrVgw7I5P8gJAvCwYPntaGpOrUhWuBfk3LBcx5otfkySjGlvm8/
 NWV4BXXI+KA8EVr1I=
X-Gm-Gg: ASbGncuwMfzXUK0UQXSKSAxqok2vqfZ/2BQ+RzIn5NrbCv/qpmE4BpFxiXQ7f/m1X0Z
 j2UkvGuEL2C62/cveafqsGBrSRc+ZMzd1Q2FCz2aC35Z88UGMO/ZKk4+hpxQ3Pq+FHC7HLg0=
X-Received: by 2002:a05:6512:3e08:b0:545:2f5d:d5ab with SMTP id
 2adb3069b0e04-54cb68810d6mr652645e87.37.1744278358206; 
 Thu, 10 Apr 2025 02:45:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcaV9D5n4EbfQU21YtIAKdn+o6GkHD+i6PL4CSpEXw7GTuJGDbcHnlhxwB8+EdxSRpPeZpiAManbWeSQEv+r4=
X-Received: by 2002:a05:6512:3e08:b0:545:2f5d:d5ab with SMTP id
 2adb3069b0e04-54cb68810d6mr652638e87.37.1744278357822; Thu, 10 Apr 2025
 02:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <1739224265-4158-1-git-send-email-andremue@linux.microsoft.com>
 <1744147477-23715-1-git-send-email-andremue@linux.microsoft.com>
 <1744147477-23715-2-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1744147477-23715-2-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 10 Apr 2025 11:45:45 +0200
X-Gm-Features: ATxdqUHPumw3VgJxPffL60PEXwD5-xGUFXC8bYsyknnOnzamCYuXf5n3KDoVhdY
Message-ID: <CAJFAV8zao3NX0MTamMThj4c09Xcz+xas9jErWTdsCCn0kRdUyw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mbuf: enable to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bf9Ye_vi1fUbWuTSwoFfwL3w-bZcT7ORSbEB7pbLU2I_1744278358
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

On Tue, Apr 8, 2025 at 11:24=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> Now that the issues preventing this lib from being compiled with MSVC
> are fixed it can be included in the compilation.
>
> The "net" library will automatically get compiled as well as it
> has a dependency on "mbuf" which will now get fulfilled.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks.


--=20
David Marchand

