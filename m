Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07840C3DA6D
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 20:34:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C55E340E0F;
	Tue, 20 May 2025 22:34:10 +0200 (CEST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id 8D9D940DF5
 for <dev@dpdk.org>; Tue, 20 May 2025 22:34:09 +0200 (CEST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-70825de932bso73465977b3.0
 for <dev@dpdk.org>; Tue, 20 May 2025 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747773248; x=1748378048; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zm6hZQjxTsbW1tR/uWE+/Qa09sMcJcE0vmHrSf2ENmA=;
 b=bHh3g9e/szyo+xOfTICJh7JAzt2FSGQqO5HbRl+CZwv9/ild55/xYR4S36O+0eKNjh
 oCsHvAsAHlVpH98MKdJkLnC/MAWOVe8SZew7QaTq4MTC+GUVGR/4o+JgoAg0eVDSBQJv
 /0uBg449pkhxMxKdLWojN3up944jCDH0VlsmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747773248; x=1748378048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zm6hZQjxTsbW1tR/uWE+/Qa09sMcJcE0vmHrSf2ENmA=;
 b=rOBOb704i+rbjs9Bxw1pEIU483ctmWov/Va1BJOsji31gX+oqur2gBby9X9BqHuhx7
 ainWseh8gbVf8UQO7JEOMb/KuucKGORZ7U1JGgpmsC7wQAxJmRZkxrCbOde7SUXILVN2
 htmEsJ2o7lM4rWgwmbge0/0KBbtjvWEj7Y844FnAYd2cRuu0SbH0OwdygVvMrd6qHz8l
 p+R56HnCJZmAO6RYXHxbI3YnCJVeFO/U491RhAiEfviNegcaph7gbfkmyAWiDX2bR63P
 rbeNhKhRs4G6cHtjwViazwODBzenorhdwPyyorgNk+GCXvk061kzTfbPLENGlaDHl+q3
 1Ndw==
X-Gm-Message-State: AOJu0YzJSgrNkIJv99uou1Y9eZm56X6cZ52RLqFy5i8KqwQFaft0MivP
 vuNcDNAfOfS9oyxQdobdFz9YHMujvDIzIQim/cVeXwyQ1qVp9ulIWMjO5lsExW/83MVyLVjN4zE
 GLTVQrxG5xCuI7fDhar818dpuMqkVDGWGaekNKA10r3nqtATdIxul
X-Gm-Gg: ASbGncvmlBKGUPXkfDY6EcoGkj9lGjeCoEwnuVKvwUsIoXnVNx0W7kuBTHHdcY9wBDS
 73VWIzHoNpyeiaTWLV08w6ujNNv4XSoOw0W47R+RHeOV5xJPc7ZybLppBOdd5zPicHP6kvdFtgn
 UaQ3CZeFpYaUYbDuTPlcpoLxTQ234BGUh6FbT7WvhaUytINP/w+XsYmpUgngg2g7c/tkg=
X-Google-Smtp-Source: AGHT+IFGxvfWyKjInJgH87wKwBb3ud4sGGjjGW6x66AMtgdOiJqL1x0PC0sRp3Vq+2HdKPmNymmVGSszdccWAVwIuGc=
X-Received: by 2002:a05:690c:88f:b0:70c:aa79:250f with SMTP id
 00721157ae682-70caa79262amr252337347b3.16.1747773247578; Tue, 20 May 2025
 13:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250423194011.1447679-1-npratte@iol.unh.edu>
 <20250516201834.626206-1-npratte@iol.unh.edu>
 <20250516201834.626206-2-npratte@iol.unh.edu>
In-Reply-To: <20250516201834.626206-2-npratte@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Tue, 20 May 2025 16:33:55 -0400
X-Gm-Features: AX0GCFtMx5ZEj8Ap5Y9bN68c6eLk9ZA_XE8nWcenSjfrwX3pnOUGsM96VHrMjmg
Message-ID: <CABD7UXNgNaC9_jfH9-YZWfskVk-ruP0wYgrVGGm5n8PuCq_z8g@mail.gmail.com>
Subject: Re: [RFC v2 1/6] dts: rework config module to support perf TGs
To: dev@dpdk.org
Cc: stephen@networkplumber.org, luca.vizzarro@arm.com, paul.szczepanek@arm.com,
 yoan.picchi@foss.arm.com, Honnappa.Nagarahalli@arm.com, thomas@monjalon.net, 
 thomas.wilks@arm.com, probb@iol.unh.edu
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

<snip>
> +      - dest_mac: 3c:fd:fe:d5:e5:f9 # MAC OF LOOPBACK TO IT'S DUAL INTERFACE
> +        src_mac:  3c:fd:fe:d5:e5:f8
> +      - dest_mac: 3c:fd:fe:d5:e5:f8 # MAC OF LOOPBACK TO IT'S DUAL INTERFACE
> +        src_mac:  3c:fd:fe:d5:e5:f9

Should be its not it's

I like the concept of having a configurations directory within DTS,
those files were starting to add up anyways.

Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
