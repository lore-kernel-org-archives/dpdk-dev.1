Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DDFC0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 18:56:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3DCBF40A67;
	Tue, 11 Feb 2025 19:56:55 +0100 (CET)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id 93200409FA
 for <dev@dpdk.org>; Tue, 11 Feb 2025 19:56:53 +0100 (CET)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-6f6c90b51c3so49138597b3.2
 for <dev@dpdk.org>; Tue, 11 Feb 2025 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1739300213; x=1739905013; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81zWzLuZUfZod1JjqG/V5JFJ8U0l9CTwxqHL7zHyLdA=;
 b=i0yJgzIw2Er6lWRhMZ6B/RM4OF5NWlGM30a84u18GR4bEfgeBwcxiW9U8IOWvVyH9u
 VpeR3ELwzU7eZr5t7Bqwe1hooKnPHPhoQSXztFZMFg+qBAanT1Awjc4LWX4ubOwaUvP+
 96b6q1ncA3utBKYtiMAUBWjEV5VHvPSkApsBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739300213; x=1739905013;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81zWzLuZUfZod1JjqG/V5JFJ8U0l9CTwxqHL7zHyLdA=;
 b=D1zkKqSmzw0prlhzqrHPZAP112cFyKIVdp1FbAggK398l8JLaGFgERpTpFsB59Susj
 vJ7I0tqP6oclRR2noRBKvorLWpc9kpYTYkPy3O09RzegpAPbN4IfR25Q/3yfR+LLL8dP
 b0s1JYNhk59dl/Gpjiti/MgsIxFkz31dLw//Eexp28IcITHkMynX22j0INkBxZVGUX4F
 VniYZfmZObsIHNQgSjH3ysV4AqcSch/DaJL+2ZEnSrKVlE03XdmNBZ9u8jc5BvosWHwp
 9RvJmkjvRB0bEVtOeVUjr7nB66VV/xILpuecB25i1NXO8d5Cw1/0yr730BLco1EcVvLn
 yZ/w==
X-Gm-Message-State: AOJu0Yyl/8qTlLJPy6vFAG7jeh2wiqu6D9eFgLrCWpRmTXh/lZgFcibq
 pTSk+vvlpcwbMfSWivCPJ52LrJx3G5p6yaZbeLBO32AKdyYCSxrE/E3wEYMw6mpY3n2sZ8eQQeZ
 Wd9Pr92H9zIlzj1G+70d0n1hCtZ5pM8au6cuQ1w==
X-Gm-Gg: ASbGncsw259mgo85WJQM//9C0MM32umyTzg/G41t5W9UxxRWpE4BLvP2SjhVdPl1uVq
 lU9tesVqLhBoA7d/Tocs5DZlJmqzdsEVx2eksbrgdbHYWu3N1afVq9gN00HZ2CnEN/t3bKKSnUA
 t89zvIaGfjs0haMqZQ4wrobcPXxjad54U=
X-Google-Smtp-Source: AGHT+IFoeOM2EVe14oAZMcjhUDPRP/FIVsykDCVpoJZMENWqWqC4kQZHpQlR91L1iM30ONq1+D3Zq1UD7Qg+Y2dctdg=
X-Received: by 2002:a05:690c:360a:b0:6f7:a6d8:349 with SMTP id
 00721157ae682-6fb1f195054mr8263737b3.10.1739300212871; Tue, 11 Feb 2025
 10:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20250203151613.2436570-1-luca.vizzarro@arm.com>
 <20250203151613.2436570-5-luca.vizzarro@arm.com>
In-Reply-To: <20250203151613.2436570-5-luca.vizzarro@arm.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 11 Feb 2025 13:56:41 -0500
X-Gm-Features: AWEUYZmHME7ts0eNzl93817w5fbSRbLLRijoB2lx-Wz5b_otyeGKr1eODXG9qmI
Message-ID: <CABD7UXOK5bYr_YzTFCqnRt4iEA7kQ6c=gJAymSMzqXx=5MEwfw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] dts: improve Port model
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Patrick Robb <probb@iol.unh.edu>, 
 Paul Szczepanek <paul.szczepanek@arm.com>
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

On Mon, Feb 3, 2025 at 10:17=E2=80=AFAM Luca Vizzarro <luca.vizzarro@arm.co=
m> wrote:
>
> Make Port models standalone, so that they can be directly manipulated by
> the test suites as needed. Moreover, let them handle themselves and
> retrieve the logical name and mac address in autonomy.
>
> Signed-off-by: Luca Vizzarro <luca.vizzarro@arm.com>

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
