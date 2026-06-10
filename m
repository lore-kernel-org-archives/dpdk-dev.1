Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7CECD8CB9
	for <dpdk-dev@archiver.kernel.org>; Wed, 10 Jun 2026 15:58:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D5E340E03;
	Wed, 10 Jun 2026 17:58:04 +0200 (CEST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by mails.dpdk.org (Postfix) with ESMTP id 66D5340DD5
 for <dev@dpdk.org>; Wed, 10 Jun 2026 17:58:02 +0200 (CEST)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-517760dc3c2so42197661cf.3
 for <dev@dpdk.org>; Wed, 10 Jun 2026 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781107082;
 x=1781711882; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1LAbZr/+eIQZRS7mEkAziKiqRoCSgpqTT+xNjtPjDk=;
 b=kmZ8/y+oJM/ChlOIDc96rWUMJ2+h4BHYl22l9FdZxEMps2iG7oZX8AJrTzKRBup6Tg
 DyXfkAPZKq4ZeUAefe/eQ2HXFS8w4Bg8g3jhWf6gfy18rFy/LYLr6eLUMuenCGh8eZ6L
 JHg2WyP3hkPBjob13c+CezJgrZqeHdzVg9rEKIYKaxQ5XHpeylSFRC4yRWjfRbM/Sz31
 a0/z6d+q83zT89EdtNMhYsvtvdyqxzHju7Earjp+5lelo00ZMn9A74yx5TrDEkFbxUy7
 lZylPmAxp+7GQajveZUk+STyI9TAVlzo0yFoo/OiRHrKwzgfzHchzdADRJz0TzBBixRU
 XAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107082; x=1781711882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n1LAbZr/+eIQZRS7mEkAziKiqRoCSgpqTT+xNjtPjDk=;
 b=SqINC7VViLZ8nufEH4sZZ+IgF42V8E9pULNm0foKZhz3FHzFb/tsmDy1IgRQIlSGjN
 SsWPZuL3rAsT1tF288ZlthLmzfAHRKpqkNnp+zFZA/x/tR/jGhGuFkoT7H73/u8z1TGv
 NCj2ZLDlZM1GX1vG9lucqmpuJgqu8cnPgmpRraLp+lXQfqvFrkCtgpGseS3t8tgWhGJU
 hxcmdEjghlSYkbuzx9ANNIh4sgpmz5XpfuQEUhMRfkItiTsCqJrPF05lfsQAxGMTpAQO
 bP1ir6WqsAHnwDBONNj9zNulUKy9GCroGXiB8MXfmwjmTsU0bSFfhRFALUEXfOev+UvE
 NWRw==
X-Gm-Message-State: AOJu0YwbFv6aQ2nldrFRv5pL2LqdUrqzFvit3S6BgzEvzeTa2Y512rzk
 +71uALl+RCEU/kYpQ20tANkU/m/EVlRLkCVbHSUlKdYF6sXFAv4LMVVvaa258kaxurU=
X-Gm-Gg: Acq92OGF9MOvlM1FraxfdBAYw1Errz08qaiITwgLkvLHQ2qxkdcZPaRmo6yeKwETowW
 TmlnBYFnyNcQvaFkGZKFahVNCm7D5BJTU223vW++Ey72Xy4Whs+7dTnsx2WErEvhIkG36AcFSfZ
 INmvM/G4XNfMfQV+CTnc1+fNZv0bWdZhFaJZUNGw1+hoE4jDE9cbTcSVcYYJZbNQAItHT+HyKsg
 Fd1INFiUQW8XRoxc6XTthW7Dof2AhxDJSaUyVuI8oxDyF4L3qDTRCU63cQ7DgDuGfYc7LVklUAf
 QUQySNXBfot5BMHZQ0t2toITk5u6XcyYLbzlKK1D01tSeX3lbs5DxV+SRLw0nqv1QvZAQsfJOvU
 N7fUjHlRr0YLZmFzLBJODolcAmjRT9NPjbYjI9G6aTMutaAj1nBWCuFjxugYUOi9YUV0B749ukS
 RRF9Umjx0kCV6jThrcnVKGlRV4EjjMNZguWDCldM005dyhPNLLXOOjq4N9v5smtLPGYOqonS4MQ
 RCkQFe9zGtWxQ==
X-Received: by 2002:a05:622a:291:b0:516:ed02:c85a with SMTP id
 d75a77b69052e-51795be0d00mr377820671cf.32.1781107078595; 
 Wed, 10 Jun 2026 08:57:58 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c08234sm218357451cf.6.2026.06.10.08.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 08:57:58 -0700 (PDT)
Date: Wed, 10 Jun 2026 08:57:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Bruce Richardson
 <bruce.richardson@intel.com>, Neil Horman <nhorman@tuxdriver.com>, David
 Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH v2] eal: add destructor to unregister tailq on unload
Message-ID: <20260610085749.7bb0a4f3@phoenix.local>
In-Reply-To: <bfa31475-848f-42af-bfb4-f796433c3073@huawei.com>
References: <20260607150418.30885-1-stephen@networkplumber.org>
 <20260609142701.163908-1-stephen@networkplumber.org>
 <bfa31475-848f-42af-bfb4-f796433c3073@huawei.com>
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

On Wed, 10 Jun 2026 09:19:42 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> >  
> > +RTE_EXPORT_SYMBOL(rte_eal_tailq_unregister)  
> 
> this should be with EXPERIMENTAL

Not possible, this is part of the EAL_REGISTER_TAILQ macro and usage
is under the covers. So if anything was marked experimental it would
fail code that did not allow experimental

> 
> > +void
> > +rte_eal_tailq_unregister(struct rte_tailq_elem *t)
> > +{
> > +	TAILQ_REMOVE(&rte_tailq_elem_head, t, next);  
> 
> We need first make sure it exist the tailq, just like TAILQ_FOREACH rte_eal_tailq_local_register()

Ok cheap scan since not in critical path.
