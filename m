Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5DCCF9E0
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Oct 2025 14:14:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A2424028D;
	Tue, 28 Oct 2025 15:14:40 +0100 (CET)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mails.dpdk.org (Postfix) with ESMTP id 80F0A4028D
 for <dev@dpdk.org>; Tue, 28 Oct 2025 15:14:38 +0100 (CET)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b6ceb3b68eeso4577915a12.2
 for <dev@dpdk.org>; Tue, 28 Oct 2025 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1761660877;
 x=1762265677; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3icYAk2JJPBK/ctKLeN63UaTzeUrfG7fNZBTHjTW7k=;
 b=NiiPt3LTB73r/pYOjh9LjcuG580L6tMhX475hIGpVwGcU7BnTlh/VYMJGe9uKMi5AE
 Uz+F5TXwI8gZ+PRgiF5Qp1FRRZkAA89Z42l99RcRKVnVDSztaa/WUuwb13xECgrrmKlW
 +uPFd7pIJif4XvVrOK4dTb6Z70mz0ZEuSTpOBpg+vyHVkEpGTJF0rfIlHlOLlgxWwtw7
 h16XF0adFl1uEIV/glef9RCgHKicEbIgRlC0E6lXmCJWwNN5ZKvnT9+QjC7CDDukflnQ
 Ri9JCnZ+tTJ7RqtTfRs2qI5ZzyLOkcI5n7y5IiL1eh2SzLeCmAIzHZZ3rOqAECEwtpyI
 NRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761660877; x=1762265677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3icYAk2JJPBK/ctKLeN63UaTzeUrfG7fNZBTHjTW7k=;
 b=P7CbLI07K0R/7TR5wTEJ5UvcUxhqNhn93oPpVHj1gUPcuXjShKRHJ8lTBk5u5PFzNW
 i5ZLmE9SyO+tEHim++XosruZpPI1r0w53U43JuRtNICEUhOaW52oWTzRgoKtruP6pWIf
 Hv8umW3UtH9nNaOyvWEdnXUR99/PJHukz09RWcK4nuxcHPDzVFIGNJcC+t8g469jnSE9
 I7YKQK3lIpJBItETaXIObhNIgxDZnNNw077GhRIM2kYYyVN+ZwF0qbsC+INGGGMtVn0r
 LiRrQiNOfctltVuMyorQLz5SeDNpMb48kP7VPgD7lsTjmT6+0vqBYPlH1IvN+rY5+GgR
 VzdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYgnhKr7eScm5G1nJff7y3naL9k6mRQl45aF3SUYs5PIHKoe0JW2FgHrqY86WyJ9Adau0=@dpdk.org
X-Gm-Message-State: AOJu0YybXIcT/8vtsSl43SokfRrjGP5xoHQ9rD03lw7CljU/hp/ta4id
 p1E6ehvny9mw8JzpqixoBHVJAhq2jBM4ERx8urtggoCI6k1QNGhdyPxMV5KPqG1VIKM=
X-Gm-Gg: ASbGncv+Mz7WaK0746dMD6zfVZ2CD/4L52NPfxKuQAF/PfaxRA/BPQlPpxtTHVljaeP
 xwFoNTkvpV7J1QD/8+xW6LKT2QrDuXapdL+gAjKPz6shSc4TbkRekgXugBSH1l7nBJrVg/8ads8
 AvDMpxsueXirjJ1PGHD/HzQkaf7DfdwT3M0hcb8uBQh7ne/Jb24tmMEx1MnhLM7qzSkaT6XxTYW
 lb53z2sRhfAf7dnAalrFY089Tv9u3eUTHhyeb8Ao9UhXIf9oE9h/1ec4LFn2pOF/Zf0q9Fi1302
 3UCSoqMqLOd8AobTLoi3QmH2+R04bYFra+YjjywcnRoFizK1dgUnDA+9ldwPyuSS9Rtz4YerKNL
 7M4oqPxOugwd2f6MXfldOmzJ8vNDYdgMVS2OkO16XQuhqqqHI0BUrAg9xEQw0QLZbEq51WBY37S
 f3NTcgEH9zWdVE6MhF1AXHkKDKrBUPEyc7Bg==
X-Google-Smtp-Source: AGHT+IGjyvsr966iQuIkRniVvGTZPFEbIkD9wUjDnzgdqqRVeLG2qRjwu06yHYfbleVpd65mMZZ0PA==
X-Received: by 2002:a17:903:1ca:b0:290:ad79:c616 with SMTP id
 d9443c01a7336-294cb6a3926mr44244075ad.57.1761660877609; 
 Tue, 28 Oct 2025 07:14:37 -0700 (PDT)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498d41c4esm120593985ad.81.2025.10.28.07.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 07:14:37 -0700 (PDT)
Date: Tue, 28 Oct 2025 07:14:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <jerinj@marvell.com>
Cc: Erik Gabriel Carrillo <erik.g.carrillo@intel.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Hemant Agrawal <hemant.agrawal@nxp.com>, Pavan
 Nikhilesh <pbhagavatula@marvell.com>, <dev@dpdk.org>,
 <thomas@monjalon.net>, <david.marchand@redhat.com>, <stable@dpdk.org>
Subject: Re: [dpdk-dev] [PATCH] doc: fix doxygen errors with v1.15.0
Message-ID: <20251028071435.6c06c737@phoenix>
In-Reply-To: <20251028141159.177727-1-jerinj@marvell.com>
References: <20251028141159.177727-1-jerinj@marvell.com>
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

On Tue, 28 Oct 2025 19:41:59 +0530
<jerinj@marvell.com> wrote:

> Doxygen detects valid errors. Fixing the same.
> 
> Example:
> lib/eventdev/rte_event_timer_adapter.h:720: error: Reached end of file
> while still searching closing '`' of a verbatim block starting at line
> 569 (warning treated as error, aborting now)
> 
> Fixes: a6562f6d6f8e ("eventdev: introduce event timer adapter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Jerin Jacob <jerinj@marvell.com>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
