Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D22C531D0
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Jul 2026 06:48:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9421640297;
	Mon, 27 Jul 2026 08:48:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E752C400D6
 for <dev@dpdk.org>; Mon, 27 Jul 2026 08:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785134892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1FJKCJKNfFE46fHu1aJ9cUCJGLHDwY4zJfLkmm0loQQ=;
 b=cUn1Eu/4tiDl+S9NJ4707fQfMgdiwHkt3fzet3gQphE/IxFs1ZIRSRb9HezjYj2g5HY+1S
 QsLUWm6j2VxhgkBfl+7cY+MnhvyY1q1PLVO9BqG38+110FpN6AkMJ7wvso1aYWuZ1LqGa6
 S43tmmrrvyX6hhCGzJlWEYhzlpemd0U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-sDNaUNUTOtmdfyb5blCN0A-1; Mon, 27 Jul 2026 02:48:10 -0400
X-MC-Unique: sDNaUNUTOtmdfyb5blCN0A-1
X-Mimecast-MFC-AGG-ID: sDNaUNUTOtmdfyb5blCN0A_1785134889
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-39accc98fffso9380491fa.0
 for <dev@dpdk.org>; Sun, 26 Jul 2026 23:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785134889; x=1785739689;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1FJKCJKNfFE46fHu1aJ9cUCJGLHDwY4zJfLkmm0loQQ=;
 b=smpm9G2uGBO/tJ8zUhRNqVyoU22eqJ2Wb0Q68t1n4DYziyA+xK+CBJ2fF45h6LNJoV
 wS3MRPK6eCcbnYd5gGz+zhxw44JhCcBTanTlw+GCcIShIwwp9O1B4O5D3y5E42wZryQi
 AMhS8Q/nNL4CsMjLMKI82n3xyvp7WiAeFJdJdjB27GTOD7lCeHLh0AMmMxZ5LqjK+d8f
 bqoXi1XZ/MV6zHbCbEnx0lpGJqTGzhpsT9I7wxAz0uyeiaJFQMs0J0kjYIHrEZByq6u4
 cQxg0CUZJzzvguEK+D1Gj/ItrXSLS4UiQoxfwsoYnxi/2bHHZ+IN8mDvm+vIomVen7JW
 hTcQ==
X-Gm-Message-State: AOJu0YxzFHAqyuWsLYDQg94mRATJPzocCRiPbFca7DJRPMNhxX1KvqlH
 bMXmTKDhwwJN7De0Yuqc/pg40WkVZf99D/Mc1bTqlygr9BKeW7KfsYfmSY3q24H+330oikmuTAi
 wL5gxbKoIoRitilyb1tVf+8xn6TmPRVz9HviLpA8kLQk4bVhk06PCC5YZ3VlCPZmaHSxAGYyI/f
 51CFMtOYaLQpXyVI5gQKo=
X-Gm-Gg: AR+sD12ooxk8sujGvdWixLxAWTThFdrsFsAgB42bBmlFQG8OsyhwOB2KQ5dumbwMkj4
 gRV0tXZ7kKHY3n8SALn74iV5R+gMjx4YcgASoNJWB2wrOfC15zRTdIfanvHD1SkWFaLR3B2l2iI
 aVjCjRXyvSOQCiM14o+dqwLd2g5CDuKnJETZ+oEbqenQYbrF0qBCVb3E0gykLqqvfSj93EDsYWr
 Z/8o6WHvIx2tOITeQ2fEpt/I3vSouXEQibd6Mt923CiNBFm
X-Received: by 2002:a05:6512:1113:b0:5ae:bd53:70f6 with SMTP id
 2adb3069b0e04-5b2c1af51d5mr1219723e87.4.1785134889015; 
 Sun, 26 Jul 2026 23:48:09 -0700 (PDT)
X-Received: by 2002:a05:6512:1113:b0:5ae:bd53:70f6 with SMTP id
 2adb3069b0e04-5b2c1af51d5mr1219716e87.4.1785134888536; Sun, 26 Jul 2026
 23:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260724084917.1045026-2-rjarry@redhat.com>
 <20260724114542.1071415-1-rjarry@redhat.com>
In-Reply-To: <20260724114542.1071415-1-rjarry@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Mon, 27 Jul 2026 08:47:57 +0200
X-Gm-Features: AUfX_mwaRBOAX80wSIq0pWVF1fDL7QVXFVyeyqK9c60TxDKR0r386kTCu8NrQnk
Message-ID: <CAJFAV8xUahKjn63Wz8pAXTd6zJWd852EfvTeExRu-5y6nw=6cw@mail.gmail.com>
Subject: Re: [PATCH dpdk v2] fib,lpm,net,rib,table: remove deprecated
 functions and macros
To: Robin Jarry <rjarry@redhat.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Cristian Dumitrescu <cristian.dumitrescu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pwZLfy4sls-ZV_Yqu5Sd0t3iKatQwkx0XCBSWlUplvA_1785134889
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

On Fri, 24 Jul 2026 at 13:45, Robin Jarry <rjarry@redhat.com> wrote:
>
> These symbols were marked as deprecated in DPDK 24.11. Remove them
> completely.
>
> Signed-off-by: Robin Jarry <rjarry@redhat.com>

Acked-by: David Marchand <david.marchand@redhat.com>

Applied, thanks.


-- 
David Marchand

