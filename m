Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8BBC636C1
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 22:00:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 416F0402B8;
	Sun, 22 Feb 2026 23:00:40 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42]) by mails.dpdk.org (Postfix) with ESMTP id 6EA4B4027B
 for <dev@dpdk.org>; Sun, 22 Feb 2026 23:00:38 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d4be94eeacso3231220a34.2
 for <dev@dpdk.org>; Sun, 22 Feb 2026 14:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771797637;
 x=1772402437; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/fVPI3Npb40v9fRiZCcoXxnNVHAOZ99+t7G4QGBb2w=;
 b=O8wweDUtQ1W0F0yE++N7YNMYh8nikcj/IuU5aKD2N+UG1GJGs+DUi5Ud5PsRq5Y6TC
 gZj334hcSA1ueQOeirC/aNrBaLKRj8Kr7rw2CKwedp3NK45t0px9h04GkLhdVcahDuEf
 qXtxES3vQsOlF3ChuYBGvgDeeDa8Nq2I/w/DSZVNfmLNZmQfox0ISumbig8G216GUu3F
 +3M3Zz56BUa43ega74pfTD9S3IcxGXYsMf4GNG1491NTWEn4PWg6UZ3z6A2mcfsWONhg
 yKh8gBeM528f4pzHfuGiIBR8ASBns8kS69Y2vj+djQJ5ksSf4F8fQESXWWY0SyM4euSG
 jTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771797637; x=1772402437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N/fVPI3Npb40v9fRiZCcoXxnNVHAOZ99+t7G4QGBb2w=;
 b=llSYS8srJ3DyPupxLOBvHQUue/U7l/m7IAIJKjy0PX0hJcEKbahptThzRUtd8xYaY2
 Nyp/ab5X8reUfYSB5SVd5zinwIv3yLopY6YcyLQJi0ICBVTD0HPJXQkhCctASHkwsQdf
 wXdOS0dVTgg0S95bcH2tOgZ1BYb7NAbAw2dBbv8lUoGzUgOA2leujLllfrapq+F3cCFI
 nmk+0uAvhzxjpZNAK/SeLX7fwESa4BwViV7Oej8EoGnfkuVuZwRP60g2KNDAmFjcBjQc
 5FJSv/rB8Joazgts5JpOKPpy6gBplvWYH7Vcbigj+4HIjV/nthJHBrfv8zDYIrAoJphk
 dnLA==
X-Gm-Message-State: AOJu0YzX7rf9oFgMBpUaCzSUH0VIUjK8+/iJ4JHYcI+Nzrr4+B5vOku6
 VCzyBLOtoLcExePzH0zH1w8zNauL2YmUZYBW1OyGzkdI39WBE1J1s+MeD0UdLcJ2CXObn2Ti71u
 01tOn
X-Gm-Gg: AZuq6aLWzfhzdDRUCQJd4UQtgyuPviYwSVT1qCm6RHuI/31cTETXRFBenVBXfCvhGt5
 KQrbDqaBHrEWizhABlMX41yc5AmrVG5P7zMn1BniaZ8Bd8/DjQpxf3IV6uhSTsJugfInr0prydG
 FZnSrVBk0rMN9drMNAuQwE/VJtaDXxFjo1cREaDSTlAhIPGofs64WyKuxFc93AnA3ZWfdjtriw6
 E4S2LbPWkbVEWoezO20qhOUpOqJ7Xspw3h2qW2z/OXEBIFYZ8aFOeM/GPwuG+bYsnlofukFWkIR
 0XcxPGnJWHTNDt7kU+LfFTODqp746b9z2iYqnOEtDmZeZJaXvOO8Zgzr7DWSiNqoZQyIsAYvNOk
 TI3iUsqUSxQ09bkO5eZzh1pYLVlsat0VlCUuj4iikQcRMeLZt+RnZ1Iyl+ecisb3g1WCBMe1mdY
 yQsTmHGUCIgbT6P+Vo0uA8xAtyuJMsAkiY846i1n4bjZeksCKja28bne1k4waQR3ob
X-Received: by 2002:a05:6830:2aab:b0:7cb:125d:2a47 with SMTP id
 46e09a7af769-7d52beb1751mr4117391a34.1.1771797637527; 
 Sun, 22 Feb 2026 14:00:37 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78729sm5652957a34.6.2026.02.22.14.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 14:00:37 -0800 (PST)
Date: Sun, 22 Feb 2026 14:00:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: stable@dpdk.org, Matan Azrad <matan@nvidia.com>, Long Li
 <longli@microsoft.com>
Subject: Re: [RFC] net/vdev_netvsc: check for NetVSC device before auto-probe
Message-ID: <20260222140034.3675188e@phoenix.local>
In-Reply-To: <20260222204813.773962-1-stephen@networkplumber.org>
References: <20260222204813.773962-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sun, 22 Feb 2026 12:48:13 -0800
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The custom scan callback unconditionally injects net_vdev_netvsc into
> the devargs list on any Hyper-V system without checking whether NetVSC
> interfaces actually exist. This causes the eal_flags_vdev_opt_autotest
> to fail on GitHub Actions runners (which are Azure/Hyper-V VMs) because
> the vdev bus probes both the test's intended vdev and the injected
> net_vdev_netvsc, which fails to initialize on systems without NetVSC
> interfaces.
> 
> Check whether at least one NetVSC interface exists (via the sysfs
> class_id check the driver already uses) before adding devargs in the
> scan callback.
> 
> Fixes: 56252de779a6 ("net/vdev_netvsc: add automatic probing")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

This is not sufficient to fix the github problem.
The container still has an interface, and cloud-init has given it
an address. But it has no route to outside (in container).

It looks like the whole automagic vdev_netvsc model is so brittle
it should be removed.
