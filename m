Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06AC5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 14:33:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DDFA402C8;
	Tue,  3 Jun 2025 16:33:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B767C4028E
 for <dev@dpdk.org>; Tue,  3 Jun 2025 16:33:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748961212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkV5w2IckmWqTB9ZzL0C3pNgEW8syPGL9KHpt+6JKb0=;
 b=EcATWY9i8GlAYTteuOuFlq/+LpfFnI3dkQJBvJ3L4uZBUev1vdZZyeHpdQsz9egNWayePS
 yw58D5FeDTD+tI5Lx0RxZDVY549xQMKOJH30HxgBcuuVH3ps50UsoQYhHhFY9Hgkkp+XGM
 TAr8LImHVrDlm9x8kAWgZldFcbatVNk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-uF3VSkCIMhybxa7O6M1G8w-1; Tue, 03 Jun 2025 10:33:31 -0400
X-MC-Unique: uF3VSkCIMhybxa7O6M1G8w-1
X-Mimecast-MFC-AGG-ID: uF3VSkCIMhybxa7O6M1G8w_1748961210
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55328b79ec3so2989099e87.0
 for <dev@dpdk.org>; Tue, 03 Jun 2025 07:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748961209; x=1749566009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkV5w2IckmWqTB9ZzL0C3pNgEW8syPGL9KHpt+6JKb0=;
 b=NLnwe5k1oKFCaeDrpVym36Xn1uR1BeSXD6SETmu9IS5KSWxxZCJUyosvD4OrpZgzWP
 dI9Z7J/VQ2hHXZhu8pOpLPepl2jjDAY5gGYwvxpqsL+U7aOfgXL5Tyut1SwoFxrKc2hX
 pXYIGeL/bB/KMsGZZslr9mFaq6CDHVdgfz7l2KpWkBCbXeZ/l9F8A5QSQHbpeL/jNAkz
 jdzFNCskfbFLCs0IjHGcBYyLq0piDwgePz03y1UQ8PO0ci0TpkwzL7IPPeHUe0C4CJ05
 yFluFSO1q/Zo2ne7OyNfT3pro+5YJZR8sb5Gx+2F04OKO35iafLyXO86PEWv015GAKn5
 d07Q==
X-Gm-Message-State: AOJu0YzlH2Zlcm32XW0L+X5wGN6o/CXbTkABCLHW9Kq0AnlXPBNZidIH
 R3K7uB8g4a/08ZWilGYaCs086zqQdSHw6eD64+oCsRqIlP2ysdVpCDQ07bhSXJ/hZF6DZFztFwf
 exmAd2Y2YQMS+xa/BCXgaEOSw9rp5QP7+Rn5ltTSMFs7eIXgFJzu6RT4fOYxkVFuFeB+m4Zcgok
 g4054Ejt/RMFLP4Rsq8uo=
X-Gm-Gg: ASbGncuByS1+1WjrDC9C1NvxRISxDBn/0d9Vl7ThHMex4LRfrH28PNC2Mwoz4FzeWr8
 /nEw6L4+1AsMqxycuHJAzTneA+Yt8J3C5lOYoNjJ7430ZkL9Pe/MftIKN0CRzREgnu9JX+7o=
X-Received: by 2002:a05:6512:10c9:b0:553:23fe:fbeb with SMTP id
 2adb3069b0e04-553531f5535mr764315e87.3.1748961209472; 
 Tue, 03 Jun 2025 07:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8/dPOeb15ofaoAX00UivuknvDAixjJoOMCCxW7kAghL1+RUTFVMkzLfBh7lQZmz40e868zZRQI9X+srzUgYY=
X-Received: by 2002:a05:6512:10c9:b0:553:23fe:fbeb with SMTP id
 2adb3069b0e04-553531f5535mr764311e87.3.1748961209124; Tue, 03 Jun 2025
 07:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <1733281010-23780-1-git-send-email-andremue@linux.microsoft.com>
 <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1747428335-3736-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Jun 2025 16:33:16 +0200
X-Gm-Features: AX0GCFtaBsJc3GmoTrSjal2JVLHgjqNXOeQKOobASN1Yr151xSj7Xlgh4tDtSzM
Message-ID: <CAJFAV8xc+WjtM6Zwu5OPLxbsiBXTshxxWeSaLv75=7-4AGnFEw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] enable fib to be compiled with MSVC
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, vladimir.medvedkin@intel.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I6LCwMn8C0Z1Tk8MsBMR3gcaiMb0uBpnssL1CA89U9E_1748961210
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

On Fri, May 16, 2025 at 10:46=E2=80=AFPM Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> This patchset addresses the issues in lib/fib that were preventing
> compilation with MSVC. The first patch removes a warning about
> implicit 64-bit conversion, and the second patch enables the
> compilation of fib with MSVC.

Series applied, thanks.


--=20
David Marchand

