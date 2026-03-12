Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13F106ACD0
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 16:57:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16777402AC;
	Thu, 12 Mar 2026 17:57:27 +0100 (CET)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by mails.dpdk.org (Postfix) with ESMTP id 486CC40275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 17:57:26 +0100 (CET)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-4671119c1c0so937633b6e.1
 for <dev@dpdk.org>; Thu, 12 Mar 2026 09:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773334645;
 x=1773939445; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jG9XGAf7GG+Y8jTxrGvnlXzAmP03cdbb+hoyFdIRQ+Q=;
 b=M+/WAkerkusmt3Ro5sdP6defIxhksTqnUUbwPIWZN5A2xxqOEgMjvktXh8D/Ii9+Ee
 PiebSuw4hiTbqMteLV6GtubTFwkQ5zZHQGjHAsAfEKzAq2TBoHI7nAdw1xRqTRvIsebf
 3+HoJbFLSKOYoKL0PrDhIYuiNXhaFPnhNG2SSmSuU/1IoZgKZNRW5mEmIDlSALyKcM+p
 SzwOSpacwZEs1UK2FrZP4LXdmHjE4d1LEP/eGG+KSbgxL0scI9hKzh9o+3vMY+6c6uPO
 B31lqQ5txEuyhMLWaACrj4pMRTvUpq+1xXuNmuSN1ZeIOW8QYGQWPgvrfhFAZwhYf5//
 twCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773334645; x=1773939445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jG9XGAf7GG+Y8jTxrGvnlXzAmP03cdbb+hoyFdIRQ+Q=;
 b=DBBPF2ApCbWgcqkwqG3DqQFaa1oumkJQQANOevqtp5tc44QWnY6n2XEmM9xmqRBw8U
 OrDUFhOzGilkl6pWYYGVJiX04ikUIo1C0zpH676sVCt2uWlo5RjbuggSzxtKDKDB+1eh
 Yz94kkGyDgDvpLrUJFT2P/rmqk/mWy3gukKixH/Xy0ryuegB3VEH+h4x7a4RQ2hnOEjV
 70M8GeBDNXQGGu9AErqnEX95pfuYgswyesfDsvdRTF/4tGyDF+pQ05RQ1ARjzHQT8FCW
 dCkS00bngCzzvDHfg1Rvbmihk98qi/0lRkRbl9XEwwh+W0HNz2EWk+67IUeAsp/BgUmR
 xX2Q==
X-Gm-Message-State: AOJu0Yy4SKMET0E575gS5nq4ZsE4oyyGNKZJKsbq6ge9yMMlU0F/cIKp
 5QRm3BTDfs1yRzaA0Jlohl4T4xrG2gz3mgXuJwdnGhw+T6SaF0zN1w7dZTAAq5QEsEA=
X-Gm-Gg: ATEYQzyE8q+COrjpUgyHRSmrGIogOo8Bg00UVK5eYNcCJwkrkyrxBxhybzh1TQLaNsI
 1ZoR8eoRn4fzfNRQ4rk4TogSXKCz3pwGmP++kk0Oip9GRSKhjCLRxCt2MQkS8FEUvlbGC/K7Byn
 /L9gDuTMUyp1kdO/JSRd4TSxB8HRFt3Zxy+I4fULvOLT9dfEL3v1BS4ZuEazRweHtCN4NC+JuX9
 6mWVBbojlVwSYmxmIyOoKXq9kCxkP3Y1iV/lN/0ECdAKzmWOGK/JICwgJescOD7iaL+M88gp37W
 3SSWdAx7C/oK27XgOzrJI4hLZyBWhcnW1ghXZ3G4/ywzP314D/DOYxuWX2+cd1zBKwYZ4ig8FdA
 oxxPIG30vCh30t6aglX1PEhwCa2GPmmD8mK1/aM10FUlJrnRfPzbjQVoZqG9/tcrA1cFx75MWQJ
 J2fr3OyCD4eH+cjvNCtu3EAtzawvfQS9WCHro=
X-Received: by 2002:a05:6808:6d8b:b0:463:ab56:9ec5 with SMTP id
 5614622812f47-46757094e90mr7446b6e.16.1773334645458; 
 Thu, 12 Mar 2026 09:57:25 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-467342fb528sm3294995b6e.17.2026.03.12.09.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 09:57:25 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:57:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kevin Traynor <ktraynor@redhat.com>
Cc: dev@dpdk.org, stable@dpdk.org, Kishore Padmanabha
 <kishore.padmanabha@broadcom.com>, Ajit Khaparde
 <ajit.khaparde@broadcom.com>, Shuanglin Wang <shuanglin.wang@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Peter
 Spreadborough <peter.spreadborough@broadcom.com>
Subject: Re: [PATCH 2/4] net/bnxt: fix uninitialized read
Message-ID: <20260312095722.54ecf61d@phoenix.local>
In-Reply-To: <20260312103606.702617-3-ktraynor@redhat.com>
References: <20260312103606.702617-1-ktraynor@redhat.com>
 <20260312103606.702617-3-ktraynor@redhat.com>
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

On Thu, 12 Mar 2026 10:36:04 +0000
Kevin Traynor <ktraynor@redhat.com> wrote:

> batch_info->enabled is read in tfc_mpc_batch_start() before it is
> initialized.
> 
> Initialize batch_info to avoid this.
> 
> Fixes: 67ad40007cd6 ("net/bnxt/tf_ulp: fix VFR cleanup and stats lockup")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Kevin Traynor <ktraynor@redhat.com>

This needs to go through next-net-brcm so will delegate it.
