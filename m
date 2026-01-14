Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE20D31A0E
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 06:00:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E80744028F;
	Wed, 14 Jan 2026 07:00:30 +0100 (CET)
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68]) by mails.dpdk.org (Postfix) with ESMTP id BE2E540289
 for <dev@dpdk.org>; Wed, 14 Jan 2026 07:00:29 +0100 (CET)
Received: by mail-ej1-f68.google.com with SMTP id
 a640c23a62f3a-b876798b97eso33890866b.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 22:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768370429;
 x=1768975229; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=05sEELVKkQ9rGxGEcHPg4crWaaIoGGTt+BanKNhpQao=;
 b=dMAOXyxTYkXPGFy7NLOCkq0/8W/0E3zzD+9At+YGpm9tlk0nuwIN72PFYEi65MWBAo
 Gubo5ZBwJiyyzSrJCFpPPVjeWXS0bpXJyJdj1u8rF03s88ZD3D79EdiHi+h2wr6XOYyM
 UurIvlpIZg8YeGvZ/KlJeWOj7oOdY+MlGQTBzgaS7nA/0fLh8Zx4M8w44BUrUuxi8mpC
 D6M2+MKpOEJCBQNgs1kNAowNkMKeLq7ysGS+aVWunqBEv4YgFeCqg9L3KXGzgU1OgERh
 T+TRcejU5mWvVlADmhaw/glUjpMK4Y3cPSRZJhcEtCvNGYHIXD3CqFoZXobjEuR/ghHq
 /ipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768370429; x=1768975229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=05sEELVKkQ9rGxGEcHPg4crWaaIoGGTt+BanKNhpQao=;
 b=CkHeMMJNXCQET+rzVNi4Sub+12wPGVTXBmWn0BHl05BVgsQjiDO4qOEqt1o4opJjPZ
 +MnBcx+/ine1PXrg2TNah+O7bZj6A5LoYux6BsayjmgrLM2NnDSVbH+AWmbNAkg00rns
 n+tqKtA9WoQ5/wB5NTE+Iz6kKr16pOctomhWjXteu17fg3MZiDoSi+Du2aRWI18GbmV8
 Wvhl2sUbn5OqCpUo6mJS+vIY+TyNYkxN9FUJmiQcTvxKqcMJ6HpCzBJzuQIrk9yUSRN/
 azdsmtPXNO5w/XksinpzOFXSVKDuGm48aH1Yo3L4Q5L2f8z7QeOORt4CYvgueyJKIl6I
 kaUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWprfYz79zpqF8VpxzDsKdJE5eRooAAShq9fpPrN+3ABxV3uLrV4ckzgcahdlcv0pu9ntA=@dpdk.org
X-Gm-Message-State: AOJu0YycFD4HXkTDFWcuz++/72jYR5vnqvtiL/rmQrHbG7hFLVPwsxq8
 DDTdOQPfYv9vZv9DBIgfOqaalKwVHc0l/7IjbhgVLxWORayE7Qy7owyCeHUPHLqoDlo=
X-Gm-Gg: AY/fxX7iczub5bQFkpXnpsaEi1pu5tY4HckR+Sk3RUgiLK/ANTAg9XOdTFWnrWQd9Qn
 E5lKOu5ALp0je9ZkFqXm8H5beUuyEjNE6y92J76NuFd2KXhsIWSs/aYXSTqMSiE4qq1F1b69ZGs
 kGHxgoWqdq5bgztcaBEfZdsZFCgt2SDSusbVuZQSwbDPLaNmlOOLmA+EtUljaqKO7IJO8Ml8/Bi
 YtnuflCPF5QeuzlfgI1dKH1nHUh92JYVIbekchvwJICDoI9HGbaUQyO2cwthKrFRDYJk65n7b1x
 o+fDAsR7roz3QkuV1MOOsBLChZCpXVmDGuRih5K4TLwxjBjp/vELtoj0pbTLQYIfLQS5falBoww
 wbPzvjMItmhdH/fyh5FbQ/Qwy/kJdwbA3Rf/qM1rtI4kyhhUZeQCOS/+08H0r5weza2HKAws5p0
 5towHH+0GeAtLXnx/b4pcO3+UbLvMutHkOHsK1J9+Q6CYiXP/Fm6Hw
X-Received: by 2002:a17:907:7202:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b87610438d1mr123126266b.27.1768370429043; 
 Tue, 13 Jan 2026 22:00:29 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a56c552sm2413547166b.68.2026.01.13.22.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 22:00:28 -0800 (PST)
Date: Tue, 13 Jan 2026 22:00:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Monjalon <thomas@monjalon.net>
Cc: Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org, Hemant
 Agrawal <hemant.agrawal@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>
Subject: Re: [PATCH] license: standardize SPDX tag for 3-Clause BSD
Message-ID: <20260113220022.65ab97d2@phoenix.local>
In-Reply-To: <3883425.DVCPrJfaZc@thomas>
References: <20251112091335.662991-1-thomas@monjalon.net>
 <7067595.Whz1cUOskA@thomas>
 <aRRWWdQjWTodkYxG@bricha3-mobl1.ger.corp.intel.com>
 <3883425.DVCPrJfaZc@thomas>
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

On Wed, 12 Nov 2025 10:43:16 +0100
Thomas Monjalon <thomas@monjalon.net> wrote:

> 12/11/2025 10:41, Bruce Richardson:
> > On Wed, Nov 12, 2025 at 10:38:44AM +0100, Thomas Monjalon wrote:  
> > > 12/11/2025 10:31, Bruce Richardson:  
> > > > On Wed, Nov 12, 2025 at 10:13:35AM +0100, Thomas Monjalon wrote:  
> > > > > Make sure the SPDX tag is used as defined in license/README.
> > > > > Reduce separator to single space.
> > > > > Use parenthesis and uppercased "OR" when a second license is applied.  
> > > > 
> > > > Upper-case or is fine, I suppose, but I'm not convinced we need the
> > > > parentheses. However, I see other drivers tend to have it, so let's
> > > > standardize on that.  
> > > 
> > > I'm not convinced as well.
> > > 
> > > Looking at https://spdx.dev/learn/handling-license-info/
> > > it seems we don't need parentheses in general.
> > >   
> > Shall we just avoid fixing the parens until we definitively decide on that.
> > Just standardize on spacing and upper case "OR"? Whatever approach you
> > decide for this release, you can keep my ack.  
> 
> I plan to rework this patch by standardizing without parentheses,
> and add more checks.

Ping.
Yes paren's look wrong.
