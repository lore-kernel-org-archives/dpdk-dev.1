Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77844C87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 14:50:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDD974042E;
	Tue, 29 Jul 2025 16:50:35 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44]) by mails.dpdk.org (Postfix) with ESMTP id 3228B400D5
 for <dev@dpdk.org>; Tue, 29 Jul 2025 16:50:34 +0200 (CEST)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-7074bad055eso12585436d6.3
 for <dev@dpdk.org>; Tue, 29 Jul 2025 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753800633;
 x=1754405433; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptvfKZRjLYGNcIylM90920OiB0TNjvT4Ei1dM1lCXcQ=;
 b=SWOdeLTOGeKh21fiVeZvb6uTT/J0MlI87yS1dbmXq+Ds71Nr7UsRde3cFKz+HrlDql
 TBkbmB8alUk1KUxY/BlzrpwFisx++oVwgPYuHN1wjEL0cMZZI3p/RnFvEV5tBa2vEHje
 2yhA3Q5kkuiS6aErusysHSDSqA1R11zwi8Oejb4j/8bJgQwCa35YqaoCKD79pRGV8ZmU
 UKMc3XoWRm4WSo3c6ijczYpA7v3WrglgGfja8zzspRtE3y1FjmY+U4vIfDnE8styAflF
 zXgcmr2xm8hRr9IIW+9HapT7mYCQ4SKwBSHuVA2CRRnmfy3AevTiPh9MCPGZw4p8qUBi
 AIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753800633; x=1754405433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ptvfKZRjLYGNcIylM90920OiB0TNjvT4Ei1dM1lCXcQ=;
 b=cZ7HiQ22/2HIj4g35eun2kXO9c8ozMK729hcbN5vTkvIRv4tTfi7wkHK1o7ajrlchj
 C70v3d8HYKh/Q6PQ8hO3xU6Mt/fUPUO1I3EToEZwDpXrf72UQXJm4IVohoavidLJ4vs3
 vpq6X1WwW1vYtJ80AT9Mi/h9duDkB0EEvgjEPw53swQoMy5ok1qLj3TXkHn2X5kVhLRq
 gQWKQfcD0Flb5hZYwz82NWKi0ObirBg7haW20BMLMsmuKEP5MR0exx2GNAQVoZ2t9pxm
 tcDICwOtH21DBDIIGM1jCfP3dclGnuq7XLwoKUuwLwmXF2xkcIzJFVx462q3YKNB4Kam
 o4Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUNHdsO3DfOjhLAEzz7lrA4AF6wvjGvGYO5Hy7IgMx4ZP3jZdQM9cMbxjTs2f5tPsOIz4=@dpdk.org
X-Gm-Message-State: AOJu0Yzz0TpzsnTYKZ1HqAaqsbZPdWHczMo/OxgOL7NuscailNY3MdPk
 tm3dknHR9mItzj6bmcNlrE4g3+Gf1IbKRXQunQ6mhmhFpmOzLKpHR/eS/qId0Muzoxk=
X-Gm-Gg: ASbGncvavyxzElOp41cBBSj9AsG+B6oBsHFNXu19WK+cL41bhaOqK16mi9MU5TPiBSH
 uc0G0coKP4yBK+ItPCfkbexU//xcjXS93Yy1xczTysoZJRbkpVj30ayyOmT62LR8Y352txskJAJ
 nGiSAZmvhoufJs0yiO2E1uFlPtOBpfH2UI8vyQnk+PRw8TEWo6Xf3JnQ/Xhn/Xe84hCCR7nCq/H
 /sCgpH9DWG5mG7cGf1s6tIzmscN4RjUe7WS9RBlIHG0tSBKOKUi+c6eblF9DmPkmB0emBN1HBfn
 umSjl9FXrsxrI/UZsLnpbbKec6CvbNzG3lvUO7bE7OKK9gfQZOAu/awMVSVRDjAJQK40Kwy95JO
 3E7OMHP95Ap+0dzy5a8qDOXm8ZkEWkWhZ7Bi9HNQKRoeVmPSpW4q3aIu4wW5TEk5Hgexrv8ANg5
 0=
X-Google-Smtp-Source: AGHT+IF5TRS1PeXlFQ2dPdlqgYi+bS6nlKbymMC8OJD6UsOeH8vhMjjHPPXQB2CzW8bhJPDA5yQkoA==
X-Received: by 2002:a05:6214:29c6:b0:707:1709:8f5 with SMTP id
 6a1803df08f44-707205ba5aemr254121736d6.36.1753800633408; 
 Tue, 29 Jul 2025 07:50:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70729c15d7csm46149206d6.57.2025.07.29.07.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 07:50:33 -0700 (PDT)
Date: Tue, 29 Jul 2025 07:50:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shivaji Kant <shivajikant@google.com>
Cc: Ivan Malov <ivan.malov@arknetworks.am>, dev@dpdk.org, Ciara Loftus
 <ciara.loftus@intel.com>, Maryam Tahhan <mtahhan@redhat.com>
Subject: Re: [PATCH v3] net/af_xdp: enable AF_XDP program attachment mode
Message-ID: <20250729075029.7fbf5468@hermes.local>
In-Reply-To: <20250729100845.819452-1-shivajikant@google.com>
References: <20250729082456.796921-1-shivajikant@google.com>
 <20250729100845.819452-1-shivajikant@google.com>
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

On Tue, 29 Jul 2025 10:08:45 +0000
Shivaji Kant <shivajikant@google.com> wrote:

> @@ -2147,6 +2189,10 @@ parse_parameters(struct rte_kvargs *kvlist, char *if_name, int *start_queue,
>  
>  	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_DP_PATH_ARG,
>  				 &parse_prog_arg, dp_path);
> +
> +	ret = rte_kvargs_process(kvlist, ETH_AF_XDP_MODE_ARG,
> +				 &parse_mode_arg, xdp_mode);
> +
>  	if (ret < 0)
>  		goto free_kvlist;

You lost the check for invalid path argument return.
