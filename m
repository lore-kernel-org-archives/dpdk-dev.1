Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6702FD216BC
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Dec 2025 16:55:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BFCC4021F;
	Thu,  4 Dec 2025 17:55:15 +0100 (CET)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by mails.dpdk.org (Postfix) with ESMTP id 2315D40144
 for <dev@dpdk.org>; Thu,  4 Dec 2025 17:55:14 +0100 (CET)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4ee257e56aaso10192361cf.0
 for <dev@dpdk.org>; Thu, 04 Dec 2025 08:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764867313;
 x=1765472113; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7+Mqk4el79/G3P2058L2V5o3oO4/URQYf2aHCcKBFc=;
 b=XvYylgNgzWZucYosqMp4Nnamhn+M+qMxY661/zV7e1+TuCSL6XOCUZ9edFSejFNJmS
 j8wZajcIOnScJ9QGgFlKtP79M6r7Mm/r6Iu6SuH+oXrkj/IdQRXTnACJ+jPEQz+v/H1Z
 2L/TldQ7TW+gTFISRUdiCS/Cx4TKQh3+XG7do6RB46saPj9bG0I4w3WXHIv+QRWlk2vW
 i2YdrpRFdHigkBTLX/uxMhyq6mBY++XxtVqbbeXrUxvoGNe336vqC1E8LIVwJGJlcG2E
 rVeGWbOl85wc+uDn+XfFv16WT+GK1uQw2Dc40DAbuaSji/HgzEqD84sdM5+a046nUkNy
 PTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764867313; x=1765472113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7+Mqk4el79/G3P2058L2V5o3oO4/URQYf2aHCcKBFc=;
 b=RyKrCgTnHsCJC0GBWVzm8h+yBOSEqMyB2fOhAZyh4lypE7xq+0VkZJCBOOr/ZEvks/
 WM2H++LNh8ZKpaB3lHmCFUX6UAvH5c2af2emNNEursNO8sNUrOzHoLo6vaWjkUCxvTC/
 LsiHk3blIBDMe5bpNYxL6IphMfFBsfcEPslschas5UbJrD03+yv7tghFEddNSnBhL+EU
 rzfr3A235BvoaNw1uq2s7tE2miYDA5Fb+dkiXD7PFMLgchLGI+QS4NdG0WSODmN4CDTk
 fNGTRkjxmgXuh5oPSX1jrSbFuthQZza8kyFZJItvUDml+i7ganJYBlhzBD/ReyjojtuT
 ZJ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0i5CXEG00Y2VcCgRjLGGEZz5X+LQzwCOkUevkeWo/aNUEwdeN+YXvaFDnBPyHPg+TdWQ=@dpdk.org
X-Gm-Message-State: AOJu0Yw5W+t7Xv5uNplnQ9Y9GdhElnDvnOEAiIZX0QUcHwrRcQqrbEKO
 uGO+x2uQNtwgLg25h2skr4NPA1ZkcAOidSbXV7k1ADQcvEuThaQeCqTDJBBB690uMohE5pRRL+y
 k62SV
X-Gm-Gg: ASbGnct6v0qd8Y9SkB7TQNjsR71/gbwtftW2cQO8gEWnSKPmpKvReBdiHO8UE4Uui8t
 bWj2qTJBHS+Ziy/R0tRia0ewVq0FDRv7hJw9LMBPZZ1+bpoDRjAptnJPEF1iy2Rs2q5YjUwswQT
 vMpoOE/vasTNo0U3C1U5k1A6gFsnXl6JcHzSuLH5mktmsIzN5Eby1mrCF8c0jQkbKdpq5Q0EZdB
 uLbrG8Ml+4NdJvJ/CKYpoP2twUfJxQDZyVGuNzEe044NVnmCLnr2RwVS6rIb8xjCRPZHoZ8QDuN
 aOGYMupapk0XddZzPUdeUDgiIKvuSoYk7G73oF9GW18+THYNXHTs9o8ioE7CAC41J7sXX7WtXI7
 4VOLFgzh6ggb6tf8dX6qu38HKVMxycj+JBzE8JYI1esQkpzJ4g5xmJeSj0fBz67QNflA71n0idj
 Pr8vTcZupXdRJDhMEkVka6W5gRihxDJgExkqzgReRdDMkuoyiANLh2jn9ZIulVdJo=
X-Google-Smtp-Source: AGHT+IGp8c1UFRRuCMFCjkHDHD4bnWq30sQyUOVxQailmU0zddkN7W0s9M6sWSHx5wpVbYMqRJI1bA==
X-Received: by 2002:a05:622a:a955:10b0:4ee:4656:54dd with SMTP id
 d75a77b69052e-4f023117762mr51517701cf.19.1764867313047; 
 Thu, 04 Dec 2025 08:55:13 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f344d0sm14346626d6.7.2025.12.04.08.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 08:55:12 -0800 (PST)
Date: Thu, 4 Dec 2025 08:55:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Dimon Zhao <dimon.zhao@nebula-matrix.com>, dev@dpdk.org, Kyo Liu
 <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v1 1/1] net/nbl: fix issues reported by Coverity
Message-ID: <20251204085508.2cb4cf68@phoenix.local>
In-Reply-To: <4726803.LvFx2qVVIh@thomas>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251030033619.3386064-2-dimon.zhao@nebula-matrix.com>
 <20251111063141.4611949d@phoenix> <4726803.LvFx2qVVIh@thomas>
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

On Thu, 04 Dec 2025 16:42:40 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 11/11/2025 15:31, Stephen Hemminger:
> > On Wed, 29 Oct 2025 20:36:19 -0700
> > Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:
> >   
> > > Coverity issue: 490942
> > > Coverity issue: 490943
> > > Coverity issue: 490946
> > > Coverity issue: 490947
> > > Coverity issue: 490949
> > > Coverity issue: 490950
> > > Coverity issue: 490951
> > > Coverity issue: 490952
> > > Coverity issue: 490953
> > > Coverity issue: 490954
> > > Coverity issue: 490955
> > > Coverity issue: 490957
> > > Coverity issue: 490958
> > > Coverity issue: 490959
> > > Fixes: a1c5ffa13b2c ("net/nbl: add channel layer")
> > > Fixes: dc955cd24c8f ("net/nbl: add coexistence mode")
> > > Fixes: 93b38df5a2ec ("net/nbl: support basic configuration")
> > > 
> > > Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>
> > > ---  
> > 
> > Queued to next-net  
> 
> Looks like this patch has been missed in next-net,
> and it does not appear in 25.11.
> 
> 

Not sure where it got lost, but it is back now in current next-net
