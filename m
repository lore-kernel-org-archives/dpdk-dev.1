Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC305CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:05:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E521641157;
	Wed,  7 Oct 2026 10:05:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 489E440290
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:05:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Kws0hI5kQ/eg7FE+xv3NlUCdqKwtZk74mGKQb/77IY=;
 b=F8uDUC1Er15eRqDFOSuQ/woLK8Y8pw4p9++Ydvo/gDLFzaoF7yzIXmp0kgkOcRP8/J99D3
 uhO0QJMhgj1W8OIS157PXOBSWvkr+wxQrqj+FGq0UueRNfy/ND8u2gHpx0OSku4no5NCsn
 DxQi41gBwtFYyqWHjMRmzdbWrZUEnNI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-hSkt3pJoMTq3A2CNG4C7pQ-1; Wed, 07 Oct 2026 04:05:05 -0400
X-MC-Unique: hSkt3pJoMTq3A2CNG4C7pQ-1
X-Mimecast-MFC-AGG-ID: hSkt3pJoMTq3A2CNG4C7pQ_1791360304
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a77d27eb6cso21699231fa.3
 for <dev@dpdk.org>; Wed, 07 Oct 2026 01:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791360303; x=1791965103;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9Kws0hI5kQ/eg7FE+xv3NlUCdqKwtZk74mGKQb/77IY=;
 b=X4l+QEZa63c3U3SVyz7+Z1XazpEud0qkGSLHkUkAWritrjtlENAyluZ8q3RSY9sJ5z
 3peY9cC5zmuRJgzj84mMrTuKOU2OlMOgIDdwNgH1qLPkFOJvWFhf+x4MOUY+l24beuGb
 orxy14R7zpV73vz/dPdfmTc4QIKmPu30OdEPz2H0U1J4z2yLPp/PdmDJIh6NBcWBQHRI
 qJpax8n/h0xXXydblVz25ejZzC54Lin5SUJnBToDo3R3c+PF7RcmeCQqTXYPUfJE8vdO
 oa3915eiyAyUZXM9PwF9cMFkrpitb2M2oqq+TgcEgKxgRdlQ1oJ+gb1ZSRYZtbrIIO8K
 MDow==
X-Gm-Message-State: AFq9FYJYneFjp5eVA4LGFB+GsxrRt0pktJgC4VIj0QTjG07P5Tno06mF
 b+6RnrSgx392C+wgzf6/0XGlCsQd0dJV8frNoppUGiDPXsOMEmErp3zN7Azt+Y9RSXV5Pre0tUp
 q6APRieHTOYrtkGYBUFHbAfkCXpeid77FRkHurZqkrUnVmq4WMqN/C5oKRWPDltJGrk6hcNP5VX
 bZhvt411GzIbxWzLvSp/0y7CAgxW8=
X-Gm-Gg: AYBFou3n2YVG5yl+/VbazaAHNObuXZc9t5FzJpAUM+dM83IFOzrye53LX00c50qf43o
 QPwUsOUSu6viXPHRmm+HH0JkQbHbVFFVVysILArxhnaH8WeK/nDUpJNA6zVc0krtaAq0X5bbVlh
 lC81j2dGimH0Oqqf27QLCCmMFa9mZC0oo5QTnoshbW6NoQa+4rEq089MQDKl+GkEq2LinbL0/ix
 /AgDbIRr1MN0/ZTRM82tBipxlTKgGm7/KUc4wTg1mIK/0Vp
X-Received: by 2002:a05:6512:6681:10b0:5bc:b68c:19b9 with SMTP id
 2adb3069b0e04-5bcd06f5d48mr286412e87.25.1791360303068; 
 Wed, 07 Oct 2026 01:05:03 -0700 (PDT)
X-Received: by 2002:a05:6512:6681:10b0:5bc:b68c:19b9 with SMTP id
 2adb3069b0e04-5bcd06f5d48mr286402e87.25.1791360302577; Wed, 07 Oct 2026
 01:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007073206.567001-1-david.marchand@redhat.com>
In-Reply-To: <20261007073206.567001-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 7 Oct 2026 10:04:49 +0200
X-Gm-Features: AclHuK_hj4ES74PeXNffCnk7HzcpyP1JqV_s2NcEEurHQW9iQXkAtMRj4yGZomU
Message-ID: <CAJFAV8y2PKNxVU+DD3M+Hxj4M_ZuOY_GyMKJWOBwFHip8CGF5A@mail.gmail.com>
Subject: Re: [PATCH v19 00/26] Support VFIO cdev API in DPDK
To: dev@dpdk.org
Cc: "Burakov, Anatoly" <anatoly.burakov@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gZ7DI_SVrCxDGpRF9BOoF06AZWukKZOI__T1TNIescI_1791360304
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

On Wed, 7 Oct 2026 at 09:32, David Marchand <david.marchand@redhat.com> wrote:
> v19:
>
> TL;DR: the v18/v19 diff shows no major changes, more could have been done
> probably (especially on the huge API revamp patch), but rc1 is coming...
> Compilation per patch still works, hopefully my splitting broke nothing at
> runtime.
>
> - Rebased so that CI can run on the series (did not happen with v18)

Forgot to check main branch a last time...
I'll resend soon.


-- 
David Marchand

