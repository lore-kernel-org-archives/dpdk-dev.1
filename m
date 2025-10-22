Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FCCCCD1AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 17:29:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0108240262;
	Wed, 22 Oct 2025 19:29:44 +0200 (CEST)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8D4814025E
 for <dev@dpdk.org>; Wed, 22 Oct 2025 19:29:42 +0200 (CEST)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2698d47e776so53236455ad.1
 for <dev@dpdk.org>; Wed, 22 Oct 2025 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1761154181; x=1761758981; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MeFKsyQy0IhnSf7UuCoqityp+LbSA4LQXJ3ulSc04cI=;
 b=bwXEBjlFa2w5cxE4W3dtUZcGtJUeDc/c+dmC7vqppNt+XDRuORgT37T2TqQbq1aVXg
 yBTUqVvclTtBpcBKL8kK0+cuRHKS80P7AtHVt+T9bxK3k8KdQh7A6Z7qWmz+Bg2NWYvZ
 NzT/LmccKP6pcu+pvPxzniBtGWT7aMSoEad5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761154181; x=1761758981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MeFKsyQy0IhnSf7UuCoqityp+LbSA4LQXJ3ulSc04cI=;
 b=TplsvyJ2WC7eTQGchAsySYVtoC729w/RTPKOpRXyag1fojlE0F48u2RJllbkbdp49r
 53GZ2vlHLdDd6LllsMf8RFP3NxuIKYmF+t963zMPc8PijaPSke1mEaggC1nnJnlKFOM2
 jO0aSN9yrXxZ83+h74OTOx9tlm/hFozwjODo9YCMOsBzoJ3juHxXrNbhciywPkLQswwL
 ainbnt0DwhxN5p8ej05wp/40Fr9wIsRQ1/9tglpKoFc3gJsQASTy+3aQp+0/eO/9BO1l
 CJOAMj1hLWoDMIhZhoYwiMfiZyYl2b3HRy/w/DZ6urdSdrafcTmjBZIjucgu6mRiKMxg
 g1kw==
X-Gm-Message-State: AOJu0YzmXu3MwHP4NM897u65nd5cBkTdwr7ycU1F0J1DWQ3lozota4PU
 rZVPMzmrde0LlCQaRr6RlgKPpzLS0c7seCjjd+UcVot70al5gi09wgTUWoAcHysJjFZEF9rHPn4
 0jB0shx/6IzPi4geHnN1LW3KBpbCmSlHq5sJjlBHBxQ==
X-Gm-Gg: ASbGncsdQ1X5Pyo2lcDzN+0stvXzJElE+OHI8fq1SChi5rLeboXsaxJF+Gf8VEkBzRw
 6/MP9yH+RvQiAvt0NLWGRcHR3aVcCY17iT62HNKiMNEfTXnv2Agtsgkyl5X2nL8T0F/X91s44Lk
 eCX31DgZGS40BLM8dCcvxQGlOFcIqhA2Uj1bWF6tebpNzw1mDXO6CjCW9t+wKU8RuWS+k2dDS4L
 I1O4wgeyJxb4OwRJJxaiE8fmalDr50XmcV3HI2R+3f1uZhfzoBRlr4tYAXhU2+hiQp3TQ19dII3
 FHovBSgJZD0PxJ+SE9T3wcfs4Za2x7SCuDKLM/c=
X-Google-Smtp-Source: AGHT+IFzWjBOkHEU+sBsHWvJ2eU0Ykf1mFy5wMgH8HBpUgOVnLVLdtJmrCJWg5miVu4Qt3SSJ5//egO5R5/HGyjRbtE=
X-Received: by 2002:a17:903:1209:b0:26c:4085:e3f5 with SMTP id
 d9443c01a7336-290cb65cd46mr265693055ad.50.1761154181514; Wed, 22 Oct 2025
 10:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20251020155536.1965938-1-bruce.richardson@intel.com>
In-Reply-To: <20251020155536.1965938-1-bruce.richardson@intel.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 22 Oct 2025 13:28:50 -0400
X-Gm-Features: AS18NWCf9wUUkJOEz3LZS2RXgxoP1GpV61MQdN4GtWVjSeU8UFdDG9ql634vxPs
Message-ID: <CAJvnSUBvK-az5zZFh=19TD4Khvi_KtzYo7Dw7vRriHhKEGEwbQ@mail.gmail.com>
Subject: Re: [PATCH] devtools/test-meson-builds: reduce output size
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000006254bb0641c2a93f"
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

--0000000000006254bb0641c2a93f
Content-Type: text/plain; charset="UTF-8"

This email is triggering a rerun of testing at the DPDK Community Lab for
this patchseries.

Recheck-request: iol-intel-Functional

--0000000000006254bb0641c2a93f
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">This email is triggering a rerun of testing at the DPDK Community Lab for this patchseries.<br><br>Recheck-request: iol-intel-Functional<br></div>

--0000000000006254bb0641c2a93f--
