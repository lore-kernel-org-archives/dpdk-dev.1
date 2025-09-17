Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A1CAC59A
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Sep 2025 15:06:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1BE3402C3;
	Wed, 17 Sep 2025 17:06:57 +0200 (CEST)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9694440285
 for <dev@dpdk.org>; Wed, 17 Sep 2025 17:06:56 +0200 (CEST)
Received: by mail-qk1-f171.google.com with SMTP id
 af79cd13be357-827ec18434aso444624885a.0
 for <dev@dpdk.org>; Wed, 17 Sep 2025 08:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758121616;
 x=1758726416; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZVgRxYYZaSDl6PHdYhACx2rSZZnmY8tVnvh1Yh2ZkE=;
 b=wjkaPfzUDqw7uftpS9WsEhXJapWP7R6KhaIdWHkuiwH9h4fPciN6XXgIOeT9J/SSR5
 MKy2umUaQnHy5ex6NbaQi170mope52rExPHLst6q8lCx+Ufax671sdy/rni7UDxf+6Js
 8lV8hckoeuf0efJJWapu56Qy1aFpodXMSSVpcxdaEAfPALKSLiT/9B5pIUXnjCh4XVoM
 M468PgGoJ6n3MpC/OYRQjVw4cvVK7KQi3h/qPRJNrPMGjMk7ZeZ5N/V/9VPLwl2OuXtD
 WzchxKpn81yQ8xAYtsyndcli8nO3U7xL0UfUUWPVBI08c9McpyNGxvTqdD3HBkvjIXbK
 hZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758121616; x=1758726416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZVgRxYYZaSDl6PHdYhACx2rSZZnmY8tVnvh1Yh2ZkE=;
 b=YCi5mHv9tk+CfNeN6nI/JKd0aq5xXN3cyvh91deSc+OBGEXfznabvI2WpxJKgJxj4r
 H6O98STPnDQ9tfV+R9Q+4IcbH5y61BH88Ud1GkyQ/bK8KQHsBHofUPrDIUEzv1eNXgs7
 m+r4iBUw10S8GB0vmnJWNWpLUUiYeCJOuOX/Fsm/DwycnvdfJ6ReaQHxtOjL1u+TpUu7
 tjTHoYabksz24RqsG1fFVGjS/ptC93mP77Q6peOdeI7PhOlZShe56bQFHpG9xcAEWhbg
 sX4mQN2tU0ATd4R3u41u3S9N1o1hN+voANdr32ehAOdepe3ugM/uqvSqCK/+LpWO7YwN
 Cwzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9NXIG7XgTIFjiZFMyzqOGNh9cXW+uG/GHUx7xaY8Jmft4aa6M3ROnKT+lH67rKzH6yc0=@dpdk.org
X-Gm-Message-State: AOJu0YxlFYlOAG1DZQdxDJEnu4b7est6kCyKP5EMsBG8Dtn2y4WJPlRB
 XRAFpAopVQ7WLvA59vksUUL9mpASATzVaJ8bOYP7mUu6cRGQJe6yZLhbnlBqHFQ4ssE=
X-Gm-Gg: ASbGncsgPMfdXkJ9qYh1ZE8jRvE1ATr+r7WOq7HVrH9BX9886d5vxa4AHgO3a0/q5Rj
 sl/I+LEzKADo3YJsYu5Mn6rfEFot7aO1sGtkUmletzQ17SCJtbOb3w93bcxdamhrkajNyyUkLI8
 mwJJVFKitPpFDuSRBC/0l7D8KcRrWMSureepGVSa7rjL6nuuVd/5YvmICx19oTA9SfFV/eV4ZVu
 E9bAIitM0FJ1rg4SYloOiltDgGOZh3r6cNtFui4RyDPn8pvkpEobVz1ivX0QRGC0TGv7xdtoLVK
 ycHTS3dj9hYSTM/TG6ppxfjljWocUKtW7fG12uw0vW0owaQ5k25qyDoh6aYAS+oXlyFZNltNt4E
 8xx8N++hH7zMmDKOCasB7mvAi6UY+iEQgevhqBwYOm3jGjge+2sxzoS0y/e6oqXyh6yePVYH1LX
 o=
X-Google-Smtp-Source: AGHT+IFGQVChsyjCU28nmh0TkHPQUUHOXcZ14uFdYIUl0Do1odVIC99wBYyNKrQBMYc5WMpkh3acHQ==
X-Received: by 2002:a05:620a:170f:b0:812:afec:d5b8 with SMTP id
 af79cd13be357-8311186d1f5mr244005485a.52.1758121615298; 
 Wed, 17 Sep 2025 08:06:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c8bb8fdbsm1176472285a.2.2025.09.17.08.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:06:55 -0700 (PDT)
Date: Wed, 17 Sep 2025 08:06:49 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: Ola Liljedahl <Ola.Liljedahl@arm.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Honnappa Nagarahalli
 <Honnappa.Nagarahalli@arm.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, "dev@dpdk.org" <dev@dpdk.org>, "Dhruv
 Tripathi" <Dhruv.Tripathi@arm.com>
Subject: Re: [PATCH 1/1] ring: safe partial ordering for head/tail update
Message-ID: <20250917080649.09317f07@hermes.local>
In-Reply-To: <aMpnqVPUDIsCj0zI@bricha3-mobl1.ger.corp.intel.com>
References: <20250915185451.533039-1-wathsala.vithanage@arm.com>
 <20250915185451.533039-2-wathsala.vithanage@arm.com>
 <aMmFeXsHI9VRn3GY@bricha3-mobl1.ger.corp.intel.com>
 <590A2369-28AC-494F-9E27-7CA9C670426C@arm.com>
 <aMpnqVPUDIsCj0zI@bricha3-mobl1.ger.corp.intel.com>
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

On Wed, 17 Sep 2025 08:47:53 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> On Tue, Sep 16, 2025 at 06:19:41PM +0000, Ola Liljedahl wrote:
> > (I am sending this from Outlook, I hope I have been able to fake a proper
> > email client)
> >   
> > > On 2025-09-16, 17:43, "Bruce Richardson" <bruce.richardson@intel.com > <mailto:bruce.richardson@intel.com>> wrote:
> > >
> > >
> > > On Mon, Sep 15, 2025 at 06:54:50PM +0000, Wathsala Vithanage wrote:  
> > > > The function __rte_ring_headtail_move_head() assumes that the barrier
> > > > (fence) between the load of the head and the load-acquire of the
> > > > opposing tail guarantees the following: if a first thread reads tail
> > > > and then writes head and a second thread reads the new value of head
> > > > and then reads tail, then it should observe the same (or a later)
> > > > value of tail.
> > > >
> > > > This assumption is incorrect under the C11 memory model. If the barrier
> > > > (fence) is intended to establish a total ordering of ring operations,
> > > > it fails to do so. Instead, the current implementation only enforces a
> > > > partial ordering, which can lead to unsafe interleavings. In particular,
> > > > some partial orders can cause underflows in free slot or available
> > > > element computations, potentially resulting in data corruption.
> > > >
> > > > The issue manifests when a CPU first acts as a producer and later as a
> > > > consumer. In this scenario, the barrier assumption may fail when another
> > > > core takes the consumer role. A Herd7 litmus test in C11 can demonstrate
> > > > this violation. The problem has not been widely observed so far because:
> > > > (a) on strong memory models (e.g., x86-64) the assumption holds, and
> > > > (b) on relaxed models with RCsc semantics the ordering is still strong
> > > > enough to prevent hazards.
> > > > The problem becomes visible only on weaker models, when load-acquire is
> > > > implemented with RCpc semantics (e.g. some AArch64 CPUs which support
> > > > the LDAPR and LDAPUR instructions).
> > > >
> > > > Three possible solutions exist:
> > > > 1. Strengthen ordering by upgrading release/acquire semantics to
> > > > sequential consistency. This requires using seq-cst for stores,
> > > > loads, and CAS operations. However, this approach introduces a
> > > > significant performance penalty on relaxed-memory architectures.
> > > >
> > > > 2. Establish a safe partial order by enforcing a pair-wise
> > > > happens-before relationship between thread of same role by changing
> > > > the CAS and the preceding load of the head by converting them to
> > > > release and acquire respectively. This approach makes the original
> > > > barrier assumption unnecessary and allows its removal.
> > > >
> > > > 3. Retain partial ordering but ensure only safe partial orders are
> > > > committed. This can be done by detecting underflow conditions
> > > > (producer < consumer) and quashing the update in such cases.
> > > > This approach makes the original barrier assumption unnecessary
> > > > and allows its removal.
> > > >
> > > > This patch implements solution (3) for performance reasons.
> > > >
> > > > Signed-off-by: Wathsala Vithanage <wathsala.vithanage@arm.com <mailto:wathsala.vithanage@arm.com>>
> > > > Signed-off-by: Ola Liljedahl <ola.liljedahl@arm.com <mailto:ola.liljedahl@arm.com>>
> > > > Reviewed-by: Honnappa Nagarahalli <honnappa.nagarahalli@arm.com <mailto:honnappa.nagarahalli@arm.com>>
> > > > Reviewed-by: Dhruv Tripathi <dhruv.tripathi@arm.com <mailto:dhruv.tripathi@arm.com>>
> > > > ---
> > > > lib/ring/rte_ring_c11_pvt.h | 10 +++++++---
> > > > 1 file changed, 7 insertions(+), 3 deletions(-)
> > > >  
> > > Thank you for the very comprehensive write-up in the article about this.
> > > It was very educational.
> > >
> > >
> > > On the patch, are we sure that option #3 is safe to take as an approach? It
> > > seems wrong to me to deliberately leave ordering issues in the code and
> > > just try and fix them up later. Would there be a noticable performance
> > > difference for real-world apps if we took option #2, and actually used
> > > correct ordering semantics?  
> > I am pretty sure that all necessary orderings for safely transferring elements
> > from producers to consumers (and empty slots from consumers to producers)
> > are present in the code (I still have some questions on the use of memory
> > order relaxed in __rte_ring_update_tail, we should create a litmus test for
> > this, to see what is required by the C memory model). What other metrics
> > for correctness do you suggest?
> >  
> 
> Not suggesting any other metrics for correctness. I'm instead just wanting
> to double-check the cost-benefit of taking the approach of putting in a
> fix-up, or workaround, in the code here, rather than actually correcting
> the memory ordering use.  Also, given that the workaround uses subtraction
> to detect underflow, are we 100% sure that we have guaranteed correct
> behaviour on counter wraparound at uint32_t max?

If you look at the code rabbit review demo, it flagged the same possible
underflow issue.
