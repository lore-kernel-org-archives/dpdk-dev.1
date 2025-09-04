Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B447DCA1012
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 21:23:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB8DA427DF;
	Thu,  4 Sep 2025 23:23:18 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 2FCBA427CB
 for <dev@dpdk.org>; Thu,  4 Sep 2025 23:23:17 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b4f8bf49aeaso1240490a12.1
 for <dev@dpdk.org>; Thu, 04 Sep 2025 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1757020996; x=1757625796; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6BZobmSYh2TwlnZL8PmeFmT/hj5mXk4quaiP/YJjxE4=;
 b=TLcl3R2KYOeBeQUHs2CTmjLuLSgmdkDLtOcNnu2zQkhC3DOQtTYQBOtWMY1ZRwPd59
 7HN4mqZixmSiFIR4WzyFlyIvyWy8tuVCgN5vzyjYFgVEmGKW8ih3hUH0/Tm5YfOlS7iS
 guYI/Dq3TuMsTc/NfUk+FW9YeiN8v9/svlX6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757020996; x=1757625796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6BZobmSYh2TwlnZL8PmeFmT/hj5mXk4quaiP/YJjxE4=;
 b=pFk0MCiv+t13VnEXOWq0yiddy5fp1KaTXUfJg+hfa5tDrXoPUFvgewotIvjUTRPR/I
 wWJ5FJRQmlU2ArsYaCDzYdJRhY76qK+k8/rGd6w+dsGzed8Sgm+SJj8QpEgjeVNfqbxC
 aguf2ea6sS6a8xaDdIsoWbr6akonxY0ZtbD2dyJ6AWFVu4mnBnCldhGeUfObI4OKFtiJ
 SXUemePm/VeKJV7dQN6buPvf2IRcLcAoZK/A9UxazqkRbqCx6MdILUQo9O3Q119Uqlx9
 fYdmAYS+kWNaVPk53UXN1RNelO+vnBM9ggoq+t7e6qRw7U6m0XFHHf7yvXDU4cCPuS42
 NCvA==
X-Gm-Message-State: AOJu0YyMzG0Sgbpzm2V4cy6quCL0SYvf3mEAoX7Xicg3jYgHb/JmQfVV
 u5GrNX4NQK2aX+LvOIrTNPzOU5qDjmEHQP1fzHFj5H4R+iz+mFg1/sV7BDWEsslPBr1YxErtOSl
 3SQcJTDN0KJ9VHTVmDAAd7dwJtH8xnBrIgAAivXXHYg==
X-Gm-Gg: ASbGncuDlam7IPWH10lYyzGsqw8A8qiTG+TyZ+c+gEuQgZ7gkXgwp2mb7efOqlACMlr
 xl4Ndob54DSPpWb6mOCAFf9i3CpUgzXwDypl0/PIHXKgfE9UatpeWiLA5re9zyMS1+s7O0dFsTX
 Gf19ZyOGZqZRg4WlZFUxT1rl8dMBTSqsUEmZO8IMffHwVy0LWWYfOC6Ln3+reASzSIGPd6xsDuu
 UMdruncE83WGeEqcz0hpJAwMZiF/DDjn9aGAuXL
X-Google-Smtp-Source: AGHT+IEqGcoT6Hlqjz3zONpl0ETpIKaSgqDYVZyEdnAseDZwqvbpqOnODp+jbptRpjecssLQv+n5rIFPBcXxNqoc01M=
X-Received: by 2002:a17:902:d2c7:b0:248:ac4d:23a1 with SMTP id
 d9443c01a7336-24944a9b18fmr296610325ad.37.1757020996288; Thu, 04 Sep 2025
 14:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250904114653.199080-1-luca.vizzarro@arm.com>
In-Reply-To: <20250904114653.199080-1-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 4 Sep 2025 17:16:28 -0400
X-Gm-Features: Ac12FXzuChuNX8K1Vh1zjJ-Jr8TztTlmDAgRAJkASlyBMAZ8ywjapnjGiqoeqsA
Message-ID: <CAJvnSUBJnkFP0RxcD1mQ9iZknGZMgHoKjAbGLFwG5QSijSpmjw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] dts: add file manager
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000058d86b063e0054ff"
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

--00000000000058d86b063e0054ff
Content-Type: text/plain; charset="UTF-8"

I think the changes in V2 make sense and I have tested it and I like the
new way logs and pcaps are stored in dts/output. I will merge tomorrow to
next-dts if there are no other comments. Thanks Luca.

--00000000000058d86b063e0054ff
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">I think the changes in V2 make sense and I have tested it and I like the new way logs and pcaps are stored in dts/output. I will merge tomorrow to next-dts if there are no other comments. Thanks Luca.<div><br></div><div><br></div></div>

--00000000000058d86b063e0054ff--
