Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3044D715EE
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 17:15:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF35940289;
	Sat, 24 Jan 2026 18:15:13 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 024FB40274
 for <dev@dpdk.org>; Sat, 24 Jan 2026 18:15:12 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso32191055e9.2
 for <dev@dpdk.org>; Sat, 24 Jan 2026 09:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769274912;
 x=1769879712; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OeDvvdBI2+oQcjohIoC4sWAZBfrLHZy31V/nBYdVBc=;
 b=hHXD86HiZr3o7epXm8yx+tXz16EXncvDNLlQKEgVK+Nu57nJ0oYqey6MQurNyfH3k3
 nNoVyeBthXxXmU5JXcM6bqvZg7xHkWwN8IFnBFRMVy6Ro5DMXdeEN8ysSl7J7KGMfcWw
 XtBltKRYAc/mmGRH/WiADOINEaPkLxn5XNVWJjTwZEFzw8qdWEuub7IenVxf0kb7xqje
 F+PX/gdOh7r6ixEvw8Ed545yUVIPTgavkPygQY4Ub70kpuh3VwiXhpNzpsZR9b6kGU7P
 i1XwI+6oFuB5lipv54ytFFOqeqoXkPZ7Rg7arneda8bn5JKn3MCw8P5M+NAQm+omQoQU
 k98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769274912; x=1769879712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+OeDvvdBI2+oQcjohIoC4sWAZBfrLHZy31V/nBYdVBc=;
 b=nHCdhn34OJ0XzjTacQjRshdxINK6hCUPSDrFB6StS/UPRbDh1m3tVn8xr1p+9KN2qA
 gU/cnjCRVjjr/KIBOPjwLJE/1iGoPQoUFOSpEpvouYqDOeNr7riUNGhEru8xSVrRBRgZ
 IyVgtNmHd3x5mk944q66tyg1ZX70OxXdzkh6uKMJE7X+DpbXuOaED5RoP+i6r7BBp2GT
 YSnEQJ73Qu01SqOsJEcoKDgXiPDbPGbnwhA8FA7+BhMBjhZp28j8lnDlfS1Dy7e7lE6C
 DcD9BavGE8t6Qz3aOx3uNddW44Ft/+n0S5mmyfkoSLcw5LTjQzqOydxLhJ2St4XcrIow
 RW/A==
X-Gm-Message-State: AOJu0Yzgl+HiY8DKq6fKJKc2pibO5jTMPtSDSzOgRP1SWTMD9jI4szF2
 +03K/2nuodqdD07AskaxQ1yNkIleF+FWqbmLzKITXf0E6o48hHrnJ4yfm3fKyfpBzOg=
X-Gm-Gg: AZuq6aL7/TEO7S4wbqmXPq4rhHPwk4hprVLcuzgHCYRcdesQQxyOewCJ4l3DSBSD2oO
 Zc83bJiOcEHU/CK5pQJcWbVFDKfsmzAJgfFlIBzxVTSHwPLxx7piAkQkEG1PsE7S/D2w8Nbn+Bs
 qrsDXlX0+cxPUwq1qQn6nBm9IilpuP7Ty+tQo1nJFWEFwjgUvGZx1n7PJirJjks4Gmo+WWfRJS/
 yigFo+fuzWzmP6S7k/LWgb3LRmhHUhb1nwLjML/1N5LY7rY3F21kI1whLj8xz+QLYESmIsy+P3l
 v6ENMz1nj4uy8MAErDoltZHNb2FoRS2Y6sWxhKNNg6IvSZwlo9rWt8ujEWAjnzJHgS7siCpvERv
 TPoiYKzMp0YEtYbWb0uizlWppXi2XXy153EgiIShlZNQzCuvr3HacrL1sD6juK4SAs+krFnzlcG
 BAa/zhgGLE7fze1IznIdV2WAxICsRjL2do2jWw4X1L4psv1sYq6oKN
X-Received: by 2002:a05:600c:8596:b0:480:4c20:6a06 with SMTP id
 5b1f17b1804b1-48052340c42mr67219385e9.17.1769274912375; 
 Sat, 24 Jan 2026 09:15:12 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e715bfsm16598324f8f.22.2026.01.24.09.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 09:15:12 -0800 (PST)
Date: Sat, 24 Jan 2026 09:15:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [PATCH v5 0/4] devtools: add AI-powered code review tools
Message-ID: <20260124091507.62a7a60b@phoenix.local>
In-Reply-To: <6e26cc4dd86545a18b7e7b7c9aec87d6@huawei.com>
References: <20260109014106.398156-1-stephen@networkplumber.org>
 <20260123004430.10951-1-stephen@networkplumber.org>
 <6e26cc4dd86545a18b7e7b7c9aec87d6@huawei.com>
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

On Fri, 23 Jan 2026 10:55:25 +0000
Marat Khalili <marat.khalili@huawei.com> wrote:

> Apologies if not the right venue for it, but I have an RFE. Can mostly
> AI-generated emails be clearly marked in some way detectable by standard email
> filters? They create quite a lot of traffic in the mailing list recently, and
> it would really help to manage this traffic (tricks such as detecting emojis
> are not 100% bulletproof).

There are a couple of things about the current AI tools.
First, they generate markdown format, so you might detect that.

My plan is to update the analyze and review scripts to have an
option to send mail (like git send-email) and use something like "[REVIEW]"
as a subject prefix. Also looking into whether there is a working
content type for markdown since it would look better in most mail
agents then.
