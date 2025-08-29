Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6E7CA0FF9
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 13:07:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D32B40263;
	Fri, 29 Aug 2025 15:07:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 15BCB4025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 15:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aHUvSjgjk70IVQx6560eDFdgMuOdZu7/PLwB+bsp7/w=;
 b=VY0GXoVAfDcjuxH8UPuj2JKL+eVSvOk8GJ3fDen7vfOs9IqGI7aqhFEfP8TmNIbEcGxCVt
 vvoUaYN2RgpYgISMfBQHP6AQ2LX9/tCI+FY3Z39PyEMRwZvS0VORNWH+R/EwUgXn3dgg3r
 QhMWTAO2bS2kwDbedsChpVyzW86rorM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-e8TvGSNFPL6ok9zWPBk8ZQ-1; Fri, 29 Aug 2025 09:07:53 -0400
X-MC-Unique: e8TvGSNFPL6ok9zWPBk8ZQ-1
X-Mimecast-MFC-AGG-ID: e8TvGSNFPL6ok9zWPBk8ZQ_1756472872
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55f41e1848dso891530e87.3
 for <dev@dpdk.org>; Fri, 29 Aug 2025 06:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472872; x=1757077672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aHUvSjgjk70IVQx6560eDFdgMuOdZu7/PLwB+bsp7/w=;
 b=JFWIucg/f9fkV41BGjX00oWBVGTudx7ylxFXEyib4MH1Pg+ccw9SXDKxAkYokbkI/a
 sYLqWnqOC7BVq4TUe6rporwm299+Q05+78m/txM1D3ayVe1zMn7Bt6W3gN1l3VoWbOoZ
 Z57N/1K4kT80lD2HuuUz6iN1vNC3xTTqHEZvz7/SmrZGKlTbytSWsHEnDmF0JkG4R6yU
 MCfrEC9+FS6RhM1ls7wIsdmBPv5yPv8UKSJiX0T8MzMAIYRVwiLYr4CFxEy4MFUqXeYk
 idNnN6US9pmCa5XV91r/iXrSeG05Au9G0R0QrKCK9nnawqaXJL1Ssa6lTftlpEoh/DB9
 xdEg==
X-Gm-Message-State: AOJu0YwPJVU9xLphGK9YuX8hJ5WdcPlPbVYgWBNyyUQ6LzrcXDc9LtSQ
 nBzOu/PPbhHgUVCgyTd2mEyhTCWwV06ufEASMH/VcwlaOBu936BlJ/G6Oin0vepz5J8ZOsf9xAQ
 1k58st0wRt/q3OV8HSxC+b2E6ywlo9RxxqGzseDbG0DsjJTum+Q8HKeM4FVvTc4ScsY6OlUC8Oa
 NT0hZcwmXeuRYMxWNtP8M=
X-Gm-Gg: ASbGncsSnmTBFUfXmZ27Avk/2E+SYiMnkkFps2DfuyAG32bAcp8+AhdRcVNvfCS2N16
 J/wIoPvQv7gP+YDL3i6n+4BFyTZ2RRSHoqonl+sj9x9lSpuQPvP309kED7jQSf1/wJiLH7UnXlx
 LVTQ0IBSMKQaDaTDBHdrB4V90=
X-Received: by 2002:a05:6512:608f:b0:55f:52a6:d4be with SMTP id
 2adb3069b0e04-55f52a6db88mr3040100e87.14.1756472872218; 
 Fri, 29 Aug 2025 06:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKF7pgWSySLsrAoSo9KBuhKq72g/5w8ajqk4vf4Xt6Z+KVsueeconJDSx8PdyVRBfiXqSEpk1qJptD/OOnXUs=
X-Received: by 2002:a05:6512:608f:b0:55f:52a6:d4be with SMTP id
 2adb3069b0e04-55f52a6db88mr3040093e87.14.1756472871771; Fri, 29 Aug 2025
 06:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <1749741884-13081-1-git-send-email-andremue@linux.microsoft.com>
 <1753122671-2645-1-git-send-email-andremue@linux.microsoft.com>
In-Reply-To: <1753122671-2645-1-git-send-email-andremue@linux.microsoft.com>
From: David Marchand <david.marchand@redhat.com>
Date: Fri, 29 Aug 2025 15:07:38 +0200
X-Gm-Features: Ac12FXydjN-EHizBVu4Z2HaUjR8hKYcEOg6APG9FMEBzi-rtZ3KGOt0tTSCFfcA
Message-ID: <CAJFAV8w-q58mxjir9a8-CiWFyOwjSRBB=Gsg9-BygqAdbAumZA@mail.gmail.com>
Subject: Re: [PATCH v3] test_bbdev: enable to be compiled on Windows
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: dev@dpdk.org, dmitry.kozliuk@gmail.com, nicolas.chautru@intel.com, 
 roretzla@linux.microsoft.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mKMhAMgaQuFfip8iXFp9QHEYo1-LLtnSDdbAwHYtnYI_1756472872
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

On Mon, 21 Jul 2025 at 20:31, Andre Muezerie
<andremue@linux.microsoft.com> wrote:
>
> This patch fixes a few issues which were preventing this test from
> getting compiled on Windows:
>
> 1) VLAs were removed: Variable Length Arrays are not supported by MSVC.
> Where possible constant C arrays were used. Where that approach was not
> possible alloca() was called instead.
>
> 2) rte_os_shim is included because this test relies on getline()
> function, which is not provided by Windows APIs.
>
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> Acked-by: Nicolas Chautru <nicolas.chautru@intel.com>

Applied, thanks.


-- 
David Marchand

