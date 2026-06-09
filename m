Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB0BCD8CAA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 14:32:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC9D3402B8;
	Tue,  9 Jun 2026 16:32:31 +0200 (CEST)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44]) by mails.dpdk.org (Postfix) with ESMTP id 8CCC04025E
 for <dev@dpdk.org>; Tue,  9 Jun 2026 16:32:30 +0200 (CEST)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-43d1470491aso1780373fac.2
 for <dev@dpdk.org>; Tue, 09 Jun 2026 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781015550;
 x=1781620350; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zsUAboxNwclXgLsgNpio/MaKY8dXtHLulm+oCAhEnMg=;
 b=rB4uqvBXDXmEJpchM+rl/TyMXp/KRGj2YHEpq/QGX8rjYCotOvbWcWm9m9uFQqHXAf
 y/GSaS5I0a3fubY/a6c4b362RQ4p3IHxWxQ+yVzFq9pBV6HHxrF+Wr3NRiIIEz5l88S3
 QIdeOtW5/M9zFBEwHcrAAKT36hHcNkzJso4J36+gUWMmvUNbquXW9VwlSlfzEgvilcUa
 hShfNJTs0TDuBEfZTo0OjtZtOjg4stGuqoEWHdv4BHoPJ3dX9CAb3ApACd4lMwLMqZLQ
 En5T/5y8ga43u8uh9R0z8hdRhUZTAKSJg2y3+93neaHze+dNlDtdofVjr1ufqSHQ/43I
 FWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015550; x=1781620350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zsUAboxNwclXgLsgNpio/MaKY8dXtHLulm+oCAhEnMg=;
 b=j0uZB/uLTBauqC5C/wPzZJvadvRCuXlzeZE5aK9e1FZHsiOtt0j8Ejd/wcBN3XZuZy
 EQ8Rb2QmXwGnTd5GcmjOXOzKDY6K4uZ2OeZ+dwHFp39Ed0jgxKPt29S9hy/bP3SCIsRc
 41CfkkKON8xoyedhKgD+HYT3trYBOfZ+0KAYNh48IHx+ku70tGmvrz44lZoRFQ36cnVP
 S7YyC1QnXO24iKkU5EoV51zEcIba7Q8sxOHGcQErtNNBYuwKyQm1cbEFcmqimaxz1hOj
 8NrVvl/pPYUKXIRTyZ3xGAZL5WAl+dY2AN6Djl4LmJUfZQUH0dpgACczLusj5olO/gna
 ciTw==
X-Gm-Message-State: AOJu0YwdjkL/hea9zDi9MUAQSCMLKcDDavtZgpQRcWMcOIsPA2m9+J6a
 Efb8nEfgbPMx4SajpdRuT83Y83JVqV8jcogqT8eimr9LRFYxVTkDzyZ98uQ9GtBOhc0=
X-Gm-Gg: Acq92OF9S40Bt6AWF99ungnFrTBEXZSPxswxGCUErOp9g4Aj2ZqPf0DbVzQSDnQPymc
 ctd5T49/r1kAntZzcWd9IFdmiSFShK/n+nXYzCNGGD64pJOm6E+ZGqREaF6WCbZKBTjN7S1NPmh
 8ZNfYcXTE8q6U2hQln3RvYdxllyGe/GsoK+9E7oXyFEesu+iDjDi5YZGlndIV2eKyMpykp0wWYV
 eEw3fufrg6CmQZwppcKMHfJCOYJJPgOAV0C0Zchdq4qU4xYYLMrleA14kRYtYaTl8DglQ6zkknw
 0XQlXcfM7Rdc69I92wvJevNftmR+U0oNWW2l8kRjf/KG3BbY9ugimtDpU5/EeGS/8NEAxoyXp3x
 2gYpAQEJ+7LXG2Sl620Ow8gNPJ6mV9UGCZR/83mKaSuCLzgMCR9CPdnetmTOZ/GbX+UKT6AacqN
 V6d9ZlwNcSbTNfyuf5/+a3NepfVhtiykbfQOLajN4f4y8+znWWSeh2YmVQ3EcIm3cVakCbQjCNv
 5w=
X-Received: by 2002:a05:6870:489:b0:441:28be:5519 with SMTP id
 586e51a60fabf-4413d240b70mr11132176fac.5.1781015549727; 
 Tue, 09 Jun 2026 07:32:29 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d4f449sm18159891fac.8.2026.06.09.07.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:32:29 -0700 (PDT)
Date: Tue, 9 Jun 2026 07:32:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Burakov, Anatoly" <anatoly.burakov@intel.com>
Cc: <dev@dpdk.org>, Jianfeng Tan <jianfeng.tan@intel.com>
Subject: Re: [PATCH v4 5/5] eal: avoid deadlock in async IPC alarm callback
Message-ID: <20260609073225.28e10934@phoenix.local>
In-Reply-To: <9f0b651c-13dd-44a1-bf72-860202f8cd99@intel.com>
References: <c5284e2f5e9fb7d664ab65115cac2634c93aa510.1780669755.git.anatoly.burakov@intel.com>
 <9f0b651c-13dd-44a1-bf72-860202f8cd99@intel.com>
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

On Tue, 9 Jun 2026 10:04:22 +0200
"Burakov, Anatoly" <anatoly.burakov@intel.com> wrote:

> On 6/5/2026 4:29 PM, Anatoly Burakov wrote:
> > async_reply_handle_thread_unsafe() can run while holding
> > pending_requests.lock and currently calls rte_eal_alarm_cancel().
> > 
> > rte_eal_alarm_cancel() may spin-wait for an executing callback, which can
> > deadlock if that callback is blocked on the same lock.
> > 
> > Remove callback-side alarm cancellation. It is safe to do so, because any
> > callback triggered without a pending request becomes a noop.
> > 
> > Fixes: daf9bfca717e ("ipc: remove thread for async requests")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---  
> 
> Okay, the AI review seems to keep flagging issues that are technically 
> true in the patches, but are intentional and do get better once the 
> complete patchset is applied.
> 
> Looks like I need to merge some of the patches or rethink the order in 
> which the fixes are applied to avoid these issues.

The automated AI review has limited scope; it never looks at patch set in total,
and doesn't have tools to read source. That is why for complex things I tend
to start a new session and give it everything. Does much better job then.
