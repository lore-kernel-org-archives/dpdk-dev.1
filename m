Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C4BCDB479
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:09:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AFA6402EE;
	Wed, 24 Jun 2026 19:09:40 +0200 (CEST)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by mails.dpdk.org (Postfix) with ESMTP id C3FBE402BC
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:09:38 +0200 (CEST)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-139b5e604b9so1548143c88.0
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782320977;
 x=1782925777; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6OQ1lCBF+Ej2uZ9IFcCG/rauIa9Q5sT2wMrClyo+LNM=;
 b=EhNP9s53JpOZxTINYNjpL+O5uSgH7zbjMVN+MWdjqx02TOif4Wm20OA5gD8q5DiIxi
 w3zuBxK9z0WPsQa6z7QqXHatVWGrDjpfl1cc/xu5u39dQ8zIKDOnSysEmuEPvKZk1595
 PBU03H5Nzy8jpYxdACUIgn9gqnJDGGtkCTZ6h5j664A91UZvCWQgnOBp6vV9MwCXeI7k
 4DxJLXOn5B8dAo4nCaz0zeDcPnHmqxeYM5QXqJtMuZwsWzhqJFL6XCuKq7MdLS9tQ39G
 fZYkj7MZQHWyBqsyFqc/Q05TRLp0AtsNYyhKJatf5FJu6E6SR4Z0fpnpX8NMUm7v7YXD
 LC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782320977; x=1782925777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6OQ1lCBF+Ej2uZ9IFcCG/rauIa9Q5sT2wMrClyo+LNM=;
 b=MbIgvtcjiDa1OijhcrVSncZMNp4kpAMHU3Qtc041o0DUm0eTmB6Pj0kNJ1yk+5XdC/
 lThF7egwdwRyyH35XC2aUEtJktmQsR5IEy/XutZZNfsqQSQHNa2DU64TTWuv5Z2C0nQ/
 LZOrCb6vnLJx97bH8vUyQbb+C3G6mfeiecjsn6AfUI14qNJcLo3srlcZw6aUSwFW7wHm
 wBe4mZMP+ZH6DCwoqo+BKp3bHpxm3rJjLv3Uk+Z+1vawY/BTJeE/zihtJ8+QRVhOtXtD
 ccGxCUy14RxlV3hBaAprviZuhn4346UjnPGljGu5Z1DMvwHttoSUim6KHGRZrlEGH4ZB
 hNjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ80mTYpFTEHlkZsy9ZtHBN7mv8JAmywZdIqh3kP0YwsKNEccszyfbMQcRN9J5e+2nGLrA4=@dpdk.org
X-Gm-Message-State: AOJu0YzXfU71IrHgKNoJf7ru3pdA6Id75PWrnoC3i+OrEC0naKEE68zD
 h5oFusi1oPBQlMzR+DJYtEfGXxGLpYW88svTD+zoDl+9UD1552MwgoDxwiE5ULhsWG0=
X-Gm-Gg: AfdE7cm8hxM2gZ6RUCGoEfgfkgyrnyzLrc72uqsU/X1suHi95zJ4R50L+QlCnkapHDv
 fc1kffOSMuYjOkoUZl2q7QAu4o3yQB21XXKeKaX0nTozigstSoY9h+qR6IFTTNYXJrUfPZBx/4s
 bfSb1COxHXrJdpsvCXlIJLCOaL/BYIxb6RMhs5eF0v3NixpXp7SK0abk7Fr0GRnUkwKIOzD12vy
 Bswe9QGNKptAIRys5nf80I7aOVc6bnAqZigtijFMVPsqLC4SGtkn0S1CIV2dkQ7H2JCYC/AT6rj
 JNZasQxL3JzVEbbOhSMiyoY7YVpkM+HG/UYWUV22Qa+lxc+FOayPnEEcQLtaMPqOK3dc09MQt/B
 NRRF/U3mDd2E3HrXQRAh+b0LpBKObv5yQgeK7AEW5l4DM2/odYj4j9RDHz2dh+DeI6b0GhJENdD
 YrZI9ELGjOEaEv4PQ6PEaYzWNP4yboh/nUAJwO56HWvg97qYdW7ps4j9OQ+uF3Y3Su
X-Received: by 2002:a05:7022:45a4:b0:127:3f2a:af21 with SMTP id
 a92af1059eb24-139c5cff378mr6448688c88.15.1782320977517; 
 Wed, 24 Jun 2026 10:09:37 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d90e940asm464299c88.9.2026.06.24.10.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:09:37 -0700 (PDT)
Date: Wed, 24 Jun 2026 10:09:34 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <marat.khalili@huawei.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, <dev@dpdk.org>
Subject: Re: [PATCH v5 02/24] bpf: add format instruction function
Message-ID: <20260624100934.00e99af1@phoenix.local>
In-Reply-To: <20260624121800.40635-3-marat.khalili@huawei.com>
References: <20260623143215.95318-1-marat.khalili@huawei.com>
 <20260624121800.40635-1-marat.khalili@huawei.com>
 <20260624121800.40635-3-marat.khalili@huawei.com>
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

On Wed, 24 Jun 2026 13:17:35 +0100
Marat Khalili <marat.khalili@huawei.com> wrote:

> BPF library already contains BPF instruction formatting functions, but
> they could only be used via `rte_bpf_dump` to dump result into file. Add
> new function `rte_bpf_format` to format instruction in various way
> (hexadecimal, disassembly) into a user-provided buffer, as well as a
> service function `rte_bpf_insn_is_wide` to detect wide instructions.
> 
> Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
> Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
> ---

Is this format similar to what tcpdump -d and objdump produce?
