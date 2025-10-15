Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE654CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:10:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DED8B402EE;
	Thu, 16 Oct 2025 00:10:37 +0200 (CEST)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com
 [209.85.219.47]) by mails.dpdk.org (Postfix) with ESMTP id 733D7402EE
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:10:37 +0200 (CEST)
Received: by mail-qv1-f47.google.com with SMTP id
 6a1803df08f44-791fd6bffbaso1737296d6.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760566237;
 x=1761171037; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAhGT31H/T56PdiqPDD4KEovO2S/au30oadbW7PGKcg=;
 b=Os8TJ+behDQ8IGDfRFb+SkQq6U4CT2lO9LlGYxEWkaOgRiqrKkGt2Ha+NMwwSb5nt9
 i7IiZTNUMm/oSH3EXCnkmnp0MArm+ivPbhkAobvwZ3hiDi1HNOIYWKgQJJL8aZ4Opmcq
 2PIYjnsRt2Lcryzi5t6GERHv64GFHmdQJrGffyrAa097pmWZMwEKfIah+ncAusAFRLvy
 im+VdWqmB7Rbg7/uwk9CtzBZey3aZozJ2W+wmtWx0plAt5cdNpHaryP7WsPXjzBL5wlz
 i5+jV99PRwwWFMzqDmHO+wQW/Sowe9e82PSy1ZCdsRKPX3QMuU4woJQyca5O5zSUZFy6
 VNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566237; x=1761171037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAhGT31H/T56PdiqPDD4KEovO2S/au30oadbW7PGKcg=;
 b=Ieyr8cM/p+KjqU+UXuXcN+X7scXDHEQnOgDMcN3lDyQ+9Y39LTtrny8pr/iNwaVNjp
 O+2jobRyU/NOtzudJYi35H7nhlVqC5VNl5XowoDjwqjSIkdRLhRMQ47MleH9HV6j5RXe
 ZjoEV14lJ/hicsryBexlCj7r6nDvPZccYmj10NYMp+QbMJcAq3NEMZ6cm3aJH4igTrm+
 7ewY6yxT3Yp+R+vgCVGLV1cifkQQbn7t8r0xRDCHM8DUGniqAdhjzMFwQh2D+p36lLrT
 BYcX4ZWJEzDGuB18jPJB3p9ClWUEEAkUkBdkYU5EX6pGfY0yKxQ1/qZOQGTHEIi/zckw
 ja7w==
X-Gm-Message-State: AOJu0Ywj+c8TMh42FUwekPRu7AgxIbLzWd3Ulvi0eOaURAsBo5tYtz2/
 iyprATSbMgmHNJlfQLUGQ7VvEePIBNnEaRDouWjWDGCO6ZLB6zC5Ur2xhIiYo+PFSrU=
X-Gm-Gg: ASbGncsO+gQGhqWr/BQQwd+2nHNJ8lVb109qu4zM7W7mijDCBePdoBQdY/o5X/zrVxz
 z896EGzRChwkhN/0p0hTebVXCPQiyVsT0VX6a7chJUPAXB6ujpeRPBuIWGNUvM/zXkAZDYFseUS
 cm9sdcNBKma0QCi7Vuya6e8rwU09u2SWJbln39bVJLteKOWoSBJdnOsN9Xkrq9YxZ8bO/pbgAT9
 V8k3dSImcJE1gtYKmKyXjV33aXkhKK+BEDu04AAkWomoMPuz8DKRviKInYn7Vdq2103y1up8iR3
 9VP/Le2j1vl1llGB14pLryu6vL0rE5hQGGsyFxrHvKerdsok9q+WSY9Z8zeZx+Tzj8IIWwZSlr6
 4i+SkXrbxadeDNBt/NUVOxEWmLHCbcV2SfS5GJnqn46m2DfpJ6wqmms1TI9VgkNwQO5IAVl7Fyd
 HcAxuI1y1C3ruE+6xz7dJUFdQxNMXfCTC28eYfdGDW4lEcpm1xKgkzkFGOV8it7nA=
X-Google-Smtp-Source: AGHT+IFEUKo7jlfI9ihpq6RmhohlN8DJtM/6kC+7vjII2bBksDcSrgqz/ER6oxHOI49v9W5chSyNQg==
X-Received: by 2002:a05:622a:130d:b0:4b7:a2d0:6a25 with SMTP id
 d75a77b69052e-4e6eaceb4a8mr371105611cf.33.1760566236702; 
 Wed, 15 Oct 2025 15:10:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c577e6sm27732021cf.7.2025.10.15.15.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:10:36 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:53:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>
Subject: Re: [v1 08/12] net/enetc: Add VF to PF messaging support and
 primary MAC setup
Message-ID: <20251015145333.4dd5276a@hermes.local>
In-Reply-To: <20251009111633.3585957-9-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251009111633.3585957-9-vanshika.shukla@nxp.com>
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

On Thu,  9 Oct 2025 16:46:29 +0530
vanshika.shukla@nxp.com wrote:

>  
> +struct enetc_msg_swbd {
> +	void *vaddr;
> +	uint64_t dma;
> +	int size;
> +};
> +

Do you really want 'size' to be signed value.
Wouldn't uint32_t or size_t be better here.
