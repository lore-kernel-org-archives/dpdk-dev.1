Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E38CCD185
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 18:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D5874021E;
	Fri, 10 Oct 2025 20:42:08 +0200 (CEST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by mails.dpdk.org (Postfix) with ESMTP id 370CE4003C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 20:42:06 +0200 (CEST)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-780fe73e337so23410437b3.1
 for <dev@dpdk.org>; Fri, 10 Oct 2025 11:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760121725; x=1760726525; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7yyeJLZ2FpxSZbVwtIRLjVtZlYAUD4jyA+O+WUhHkQg=;
 b=i3f1Mmg6ydIivYhWYNqMUp8Uv5+HNXGEpUYMMSlK+BfFL00zfgTI87ovHn+oFYp8Dw
 e3qcz1HwY+JZ/qdlZT3+sfWN+IOwmWWkKMjdbRc2n0AzruLX51kt/blt+oKn/0cnX1il
 kHqlMovIa5+5ptZATT68mYqgVJQ34LMN0HcbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760121725; x=1760726525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7yyeJLZ2FpxSZbVwtIRLjVtZlYAUD4jyA+O+WUhHkQg=;
 b=jKfpfBvRgkxGVtQYJYaQRiaLst/KOhDPDw5Do9oGBEGENwA3KKoFYDkoZ3/yrJw8EB
 bWFcyPWtbFwBh2uyp4C2aSaoFt+zhwYFjHY9dWokU0nKXzp7jC998JlKBkMnGITwqR5V
 ctkQS+At+zR+tB4vlQbkaJQf8y/3ORHlqTwF5ASgGfhaBUZUgmY8BRdhOjnZTO4+9ZKZ
 c4dKP680LdscAZcLDrmGID/CRX7ZprnLOXx2uISBYVozbdcFhuw9Kb1rzL8fXGOGU+YQ
 iSdEpb6Lx3iqsdvTLcj2OwbJPHp+Z1EOdWr1QizdOGRuDrB83OCKAgGG1SP/EFo0haUU
 LxJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK4hL4TTqGQqEt3Z5gr8QN3QxXbbTZb4iBH7l8QQ7ayV7/LFcBEQK9X5apdvDzYosSDAU=@dpdk.org
X-Gm-Message-State: AOJu0YxV5kjmJP8aDJNAADIyeN036mICG54ojzugWu7ciPv24Vl8Ecix
 MtYkCO40PUrQVtrmIwvWXCyowDoE7JxKSZ2B870u2wJk0BRbf4b+RGUO38c3ebpGlSm2zqOYK3w
 f/+cyCpHW3shXPBUqHvfF3dYNqEprU9SFfkW2e0zNFA==
X-Gm-Gg: ASbGncsLbf8e1fjd0734twuoPwd5Ka+qjhkOMVs9w06I0GMthC2S8FTy19GeClz1xyy
 5KFZV3Vl9xBTK+IaIZlgWukULp4rTBmXElDb/pgnoGTIztVYDTENeo0El54KzPG00ZhxzO1u1zX
 v35MBn02LHL+66c04IaSV/Jldnk6GnjFlY0SibUHptSMJjzFbPj2PT/jH+W1ttqqXBAhY4TPA+9
 X3eX2aFS6AEo7/7Ot6D9vGUWQL1xn/bX3PUjJ3OSvZFEwVgyOo=
X-Google-Smtp-Source: AGHT+IGdwhuFetdcMKGhPHZV+Xo4ZSZnVxmiFkterXJIZ1DwWgrdgKUdws4cpaCLs0wuuWamkoi2/k7eq/TpB588NeE=
X-Received: by 2002:a05:690e:245:b0:63c:f5a6:f2f1 with SMTP id
 956f58d0204a3-63cf5a70632mr97885d50.67.1760121725472; Fri, 10 Oct 2025
 11:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20251001231659.2297751-1-probb@iol.unh.edu>
 <20251001231659.2297751-4-probb@iol.unh.edu>
In-Reply-To: <20251001231659.2297751-4-probb@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 10 Oct 2025 14:41:54 -0400
X-Gm-Features: AS18NWAaG-wKiQFA8VY-vnnIl7p1iDxVjC6SW7uG44BAvDxXT0nCGRl5bfnjd1s
Message-ID: <CABD7UXPUHkzJUwQiL_VvNPdNrvtQmc-kty6iEkdFM+30NxZ5iQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dts: add performance test functions to test suite
 API
To: Patrick Robb <probb@iol.unh.edu>
Cc: Luca.Vizzarro@arm.com, dev@dpdk.org, Paul.Szczepanek@arm.com, 
 abailey@iol.unh.edu, Nicholas Pratte <npratte@iol.unh.edu>
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

Tested-by: Dean Marx <dmarx@iol.unh.edu>
