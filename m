Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDB7E87839
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 14:18:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3E2A4029D;
	Tue,  3 Feb 2026 15:18:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 85F594013F
 for <dev@dpdk.org>; Tue,  3 Feb 2026 15:18:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770128279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=prtsw4qdU2gKYBh4o/s/9HxH+NrvLicXfKULMxDRkUQ=;
 b=U/pACW3fNgpgMmW7tVbuKiT0FgX9unG4v94cCYEd/ngr0mKbhc5gFlC+UUyyo1N4wcqwbZ
 8d1vAkf5JmBTVNMWDmhAkTvp+qcySuyABGbOAOU61ioYiB06P2Nc3NTqb3xGfz4sZPhAki
 lxl1s9zR5/KjD1AfUfT7QTDws+APbG4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-tJP4Ld13MNiU2qVFv33HMA-1; Tue, 03 Feb 2026 09:17:58 -0500
X-MC-Unique: tJP4Ld13MNiU2qVFv33HMA-1
X-Mimecast-MFC-AGG-ID: tJP4Ld13MNiU2qVFv33HMA_1770128276
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-382fcf9cb7dso30727841fa.3
 for <dev@dpdk.org>; Tue, 03 Feb 2026 06:17:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770128276; x=1770733076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prtsw4qdU2gKYBh4o/s/9HxH+NrvLicXfKULMxDRkUQ=;
 b=a5EZ4n33lDI7LJAS92lk5nTMHN0EPpz6CHgyrFXw0vXbuxLtSJQ/veLg8AisV035Jd
 STtL42msge9IQWnB/YzA/mbqiO38WoReN8VKb+C4CRTqdcjF5O4TG3yBZmDdL+Lp5gP9
 oa+B7MVP0gCnlVFDHJp4f5saIGQY+HShlpaLKqlV15boxYkOWnKM9h2Acwo2VkFLpZ77
 aLRPFBeRmWOnpIIn5js9q8opTvBOCJxcBQg3SxNbfyk4OTOcqGx1kDVtra0h7lGibMZE
 T0kxPpy3TO0FNsHsoVlyZU8r2oHgtrkBeLhR2/VE7/zpc0mskWzBrLEGLZvHRiGXieCx
 n1fA==
X-Gm-Message-State: AOJu0YzLQMXb9u9kFZ6KMG298Dtnk0vOLQN+UWeJqRaHfo9idVzSaJ1O
 Sdqlg2r68b2uVfTAl2+vT/CeO8nl24gJtNgrniYG3JtwoXI3GGodyrClFD80ic7osjaM5wlKPU0
 QWJc5H5PXEJvsFQmxbDw/lSTpICJqnql9yNODd+KloAgVhHaJbtUKiBWkkuuMbTHcPYgAHANVIG
 Vw4d4avrZbu0ECn/GH624=
X-Gm-Gg: AZuq6aLjjmcI/dayLvSq7tT6ZSs9a+Cffh4yjBuHapm30TQ9PRH7kcK5jz8tJxW40mC
 9x42zP2d5gJiJt5erIE5nX2LLnUfZ9Y7xX1K80VP/RSnKtOzmiz6kRWhAJG5EC0PXR1Ey5BbXF8
 do3EIKbqKHQrEIEcqL0kdJYZirUB7ssAXGNCjXbLkPBLfuEE8uUetI6CqRVUvSrqFpxpGCCtErS
 LT09OwFJ0WmXsBjOpCXcRZE8iFn4bKtEmxvL5wULZUeQnHaBxeIYQOiHQ==
X-Received: by 2002:a05:6512:3f1f:b0:595:81eb:5368 with SMTP id
 2adb3069b0e04-59e1643285emr6094299e87.39.1770128276118; 
 Tue, 03 Feb 2026 06:17:56 -0800 (PST)
X-Received: by 2002:a05:6512:3f1f:b0:595:81eb:5368 with SMTP id
 2adb3069b0e04-59e1643285emr6094283e87.39.1770128275706; Tue, 03 Feb 2026
 06:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20260126164519.3029952-1-bruce.richardson@intel.com>
 <20260126164519.3029952-2-bruce.richardson@intel.com>
In-Reply-To: <20260126164519.3029952-2-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 3 Feb 2026 15:17:43 +0100
X-Gm-Features: AZwV_QjSPHHYoOopPg_yEQXb5JxLDMzEz6YHi30Bmj0RVRxV15HMAJyJHGn0eAI
Message-ID: <CAJFAV8yRYXKjQCniarc=u9fYuh-1GYTnKr-fnEJDQwEOrZuSeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] test/eal_flags: add EAL debug logs to recursive calls
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xHa9eyIpgpNYix4amZLP3Le4tbtxQUKHuTlIYw0rsdk_1770128276
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

On Mon, 26 Jan 2026 at 17:45, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> When we make recursive calls to dpdk-test to check flag support, either
> as a secondary process or as another primary process, add the log-level
> flag to give extra EAL output to help with debugging any issues. For
> calls that are spawning another primary process, pass in --no-pci flag
> too, to skip device probing.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

On one side, the debug will probably help with future errors.
But on the second change, the --no-pci stuff is not about debug it
seems more like an actual fix (or well, a way to hide the issue in
CI).

I would prefer we split in two.


-- 
David Marchand

