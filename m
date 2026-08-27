Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA45C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 08:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A15840150;
	Thu, 27 Aug 2026 10:54:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BD5C54003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 10:54:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787820878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9qPIeaduGQ73kKmZn208iCbNtNZGNAFqUvmnQvi7B2g=;
 b=Mawya6yV0V9vWsJX5dXSkBT9gT+JM4bENTq0WfMFau8FsmXNgG9tWKj8YuKyCrJ/kgD2IM
 1nkGQZ2/z9ab0wo7tp6a9Mta9iKau6sXBhFmoSh585NLggBc+zv2Um/Pu098RJHEvnoT+X
 DI6DaFiIi1FHEX0BT0g2/v4KGBlqEEw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-bEuQBp3YMI6zfEP43OCmCA-1; Thu, 27 Aug 2026 04:54:36 -0400
X-MC-Unique: bEuQBp3YMI6zfEP43OCmCA-1
X-Mimecast-MFC-AGG-ID: bEuQBp3YMI6zfEP43OCmCA_1787820875
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-3a202ac1011so8794091fa.1
 for <dev@dpdk.org>; Thu, 27 Aug 2026 01:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820875; x=1788425675;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9qPIeaduGQ73kKmZn208iCbNtNZGNAFqUvmnQvi7B2g=;
 b=Pexd10kbkZD2FUynREgKQ5XDFUJAWWhn39K6+LExD0hSt3mbGEEcrlFNm6m9GPdcmC
 uQ3RsNGiGtu+GVGb/vV8RruE2xPmHpc/d50xOF+OAE7y3eoo1ut48SI8s9phusrZj2Nk
 MQPQv8iHhipxRIuMFYrNayQ+Yww7a1dAaECfDr8na/r97UbXwEF8fWSfHfCz4kGZsv2A
 wb1oqagvkYJfRIAqjueS3AFhYwyC2aqNKdaTaoJq++yo6fp1aVTWpfaJSugdrn+H2IfI
 +G7pn6NqYz9YwXaToLSPLuVIKOWrMDrQMJ6/U5iJ+icLlK/RexAkbGvTydV7j3r5Rsjh
 sgaw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/BA9ru6S1Wfdk3vdjSHN0EYdO07kboiJs8GYYkatJwfTS5ZEes4nlEpLMw/DaNYw4Leo=@dpdk.org
X-Gm-Message-State: AFuF++nrXUwSmR5zO5I76dc9gKqK9WfYIQQBW2wjH4PqPFwMalTr4PNd
 sA5iab1Pt5qcnZ8DTiueZ1DTTqjLiyh0NlOzkVbDunDi6yGBj3QiVBvCbPpIWZSqbvlvPRjXqkM
 GtkVMqwQvKVSYTBgPipFUgfCjZynUXHgVEF1kP5pH7HYwjstfA2PmI4GBAvRMeIvFFwG6/22opU
 3hg3Lal6tyJZlBGJZTgd0=
X-Gm-Gg: AR+sD12i+0V44Otf86RbRGMkZQCX1oOapA2RyaH3f1b2NrN8IkU5nIkRJiNTwbVdcnt
 Sr2nYy/vvANAd2DDnAgfd3rBxAW0LBE2amVJluS6I0u1li/HG5P0dfepKe2v44a3EyPev4fIEJB
 HDftGbmQok8Ed98tRDY2M8qzvfh07ltLky8zRCmzJLduQOEIYZdDA8IN79l00aAKcNfPQ+jcVFq
 RUNXY5FZ5BrMrWf4w4rffDqU+iBjG9/OREeQy7flKQb6WET
X-Received: by 2002:a05:6512:3d0e:b0:5b4:c00d:23f3 with SMTP id
 2adb3069b0e04-5b4c00d25f2mr1488331e87.14.1787820875414; 
 Thu, 27 Aug 2026 01:54:35 -0700 (PDT)
X-Received: by 2002:a05:6512:3d0e:b0:5b4:c00d:23f3 with SMTP id
 2adb3069b0e04-5b4c00d25f2mr1488310e87.14.1787820874976; Thu, 27 Aug 2026
 01:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260827072854.1015059-1-prashant.gupta_3@nxp.com>
In-Reply-To: <20260827072854.1015059-1-prashant.gupta_3@nxp.com>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Aug 2026 10:54:22 +0200
X-Gm-Features: AcwNN1Uafe-pioQqYqOreC9hFi9XVTLLZ36b1stIznk-ZqK2zkwF6EMg3aalpXM
Message-ID: <CAJFAV8yZBb7mQb+cEyuq_XnbQTaFxntTXz0sUm3NCMYsT0eDDg@mail.gmail.com>
Subject: Re: [PATCH] bus/dpaa: defer bus initialization to probe
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: stephen@networkplumber.org, hemant.agrawal@nxp.com, dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 45x68F0qpXZcXH4d4rIiGItjfMmhQgMVyuzdHEpbCDg_1787820875
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

Hello,

On Thu, 27 Aug 2026 at 09:37, Prashant Gupta <prashant.gupta_3@nxp.com> wrote:
>
> In the DPAA bus initialization: it builds the
> device list, loads the QMAN/BMAN drivers, registers the platform mbuf
> pool ops and populates the PA to VA translation table. All of it needs
> the DPDK heap or a memzone for multi process scenarios.
>
> get_iommu_class() for this bus only checks two sysfs paths, so the
> initialization is not needed in scan to report the IOVA mode. Move it
> back to probe.
>
> Fixes: cdefd2e980bd ("drivers/bus: initialize NXP bus specifics in scan")
>
> Signed-off-by: Prashant Gupta <prashant.gupta_3@nxp.com>

While the change looks correct, I don't understand what is being fixed.
Could you elaborate on the issue?


-- 
David Marchand

