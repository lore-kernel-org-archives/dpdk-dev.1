Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F747606A33F
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DbkQNYum
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EBBD4026F;
	Mon, 16 Nov 2026 20:04:43 +0100 (CET)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTPS id 99C9F40150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 20:04:41 +0100 (CET)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cdd9d0c9bbdso2942566a12.1
 for <dev@dpdk.org>; Mon, 16 Nov 2026 11:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794855880;
 x=1795460680; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hYwk8EOQu0lDY6ZKx8sw3Ze5epkvaCI2JLKr2ADMaHI=;
 b=DbkQNYumvgD3ufsU3oGKUQyKEN236j8RZRi6V4gPtalrLCUdfY/K1X4xS/siULthb8
 JiRGZrvDrlkxIZ3Ygl4irplMc2F4Hj6NTgIunYXfnAWZShykBgHDRTiHYGAotD7HIVtE
 GQ1LlSKNMkKCb0TwpOl8Y4y1SH4ncxqOScP9VhcAJd4qbbvjrHUF3cgPE8x8u7YPYWpG
 owNCpYWqS22khDeryZ854/SqLmuYLrkpxxmo5i8CYPrOAVgL2NDIohyeD8Gij+lcQGQN
 JYCNoHODa4MLBzNGs6qj+fhkpa/Wyv/wki97cYeJDup8dFIk1hp3/okX8/zVKMBHsTEk
 phqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794855880; x=1795460680;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hYwk8EOQu0lDY6ZKx8sw3Ze5epkvaCI2JLKr2ADMaHI=;
 b=r/yhev/xUailcj00qnJUHamMoVU3kEwefxhFS8cWJRFTn2Jq+eLd+2yNVG2KsjBmOV
 KdcSWIH8riiueEf6bCnMFBZjvRexQXEfGCHMEZepDBJU64JX85b3yRRjQYxNrP514FGx
 8De+Hg8RyIuZP4g29/hw29acTWI5an/Icdtj9OZtPEpkxg2crqF2/20cktBYnjUx2j6f
 zYPJ1xhJwwHWkbj67r2lAB1SW52y1hGqD3eGPV1uPwC8/W4/uXd8d3j8qDcBCtD4MjeY
 AfYlLnBCqaxFC8CK5tFsbgRyNpE63jveATFFGo091CdanliEhMF5+QfARQihmGEOMm3R
 JZeA==
X-Gm-Message-State: APuU4Z++RO9vb2P+Mhp5mCBJEp9j3Ew73gmmAKybBZ5vsE2iPHVoiglT
 p25fpmVU6M5kfIeRwI1QONFjsgvVJgqBPu5E+LpYweQCWaU+TvoX/651z+96h8mNKcc=
X-Gm-Gg: AYBFou3ncWYbS1FYCjsgFa5UxCJj6l2FhW2wb1DqA1X/R4U8LNcRNEcAX/VeyQGgJ8h
 acYDjybhqey98gS3n253YHk15M5loU4nGFOPeLeKXT9L98Y+roriGZAUfS01VLT0GkOCxh+FO6H
 5XUKAzifc0UxdgeujOxAiMZSnKNgigZrlV0Ajrs2BtyRcp0MD8Zgrz+196ES7weO1eqqp+I6dgy
 TzEDR7DKIPh5gJ4rWJVrCBeTfhWtj4j2+ZQbs+sdZxVKNNKnr3FKGB0VPScBD0plS11ciEtYNtg
 WEziAvjFhuc67jZfWJOKfPB6doS1WIC/2yGKDWJno2utrdWVSgsKZQpTtu4UQguuLeyW2idZzqu
 7WekcbnVrFHvxcXDfHXq6IJ/M2PN84KP3PYFLJr36ATyOITqYcGlKsv4FZqfJWdrVfXZ4TLkarT
 TaSm4mh+vEVicKpSSMaFOj7mSas3BOENoTXbIiSPWL6H6+CnlY/K9eJsJNNGUmmaNAJVyw58Z4m
 gS4Kw8o6nQfgzms4kEbbwM3tk8W8IrECgjdQfZLr8eunGzhzsrPTY89i6UWxG21nIiMDQEp96dp
 elYN0Rxx8n1vgg0umedVmxzt72457+7+yNSkhXW3ilBmY0Sn1wgPIz8XDeHxf+3QITnqLYQaxgY
 KlSY7750Ijgw/DIu7C4xV
X-Received: by 2002:a05:6a21:8903:b0:3f0:43:2bb6 with SMTP id
 adf61e73a8af0-3f7a4fc506amr9582870637.7.1794855879421; 
 Mon, 16 Nov 2026 11:04:39 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cddc18adce4sm4563184a12.23.2026.11.16.11.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 11:04:39 -0800 (PST)
Date: Mon, 16 Nov 2026 11:04:36 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Frank Dressler <frank@dressler.pro>
Cc: dev@dpdk.org, stable@dpdk.org
Subject: Re: [PATCH v2] net/af_packet: fix accidental fanout group ID reuse
Message-ID: <20261116110436.0811b964@phoenix.local>
In-Reply-To: <1601da16-4251-4b44-8190-4503574abc83@dressler.pro>
References: <20261110190626.519592-1-frank@dressler.pro>
 <20261111104536.248312-1-frank@dressler.pro>
 <20261116094125.239f7bee@phoenix.local>
 <1601da16-4251-4b44-8190-4503574abc83@dressler.pro>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 18:53:54 +0000
Frank Dressler <frank@dressler.pro> wrote:

> On 11/16/26 17:41, Stephen Hemminger wrote:
> > On Wed, 11 Nov 2026 10:45:36 +0000
> > Frank Dressler <frank@dressler.pro> wrote:
> >   
> >> This fix ensures that the queues of an AF_PACKET vdev do not
> >> accidentally join an already existing fanout group in the same netns.
> >> Joining such a group would make each member receive only a fraction of
> >> the packets.
> >>
> >> It sets the PACKET_FANOUT_FLAG_UNIQUEID flag for the first queue which
> >> asks the kernel to allocate a new, unique fanout group ID, then asks the
> >> kernel for that queue's fanout configuration which includes this
> >> generated ID but not the flag anymore (the flag is ephemeral) and then
> >> uses it for subsequent queues to make them join the same fanout group.
> >>
> >> The bug exists since the PMD's introduction in 2014:
> >>
> >>    # 2014 DPDK:
> >>    $ git show 364e08f2bb:lib/librte_pmd_af_packet/rte_eth_af_packet.c |
> >>        grep getpid
> >>      fanout_arg = (getpid() ^ (*internals)->if_index) & 0xffff;
> >>
> >>    # v26.07:
> >>    $ git show v26.07:drivers/net/af_packet/rte_eth_af_packet.c |
> >>        grep getpid
> >>      return (getpid() ^ if_index) & 0xffff;
> >>
> >> The chance for a collision might look low initially as it requires PIDs
> >> to be equal mod 65536. But the chance is high for applications running
> >> in containers having individual pidns but a shared netns, which can be
> >> the case in a k8s pod, or also with manually started containers, e.g.
> >> `--network ns:<path>` in Podman. The individual pidns increase the
> >> chance of different processes having the same PID.
> >>
> >> To quickly reproduce the issue, you can start multiple AF_PACKET DPDK
> >> applications with qpairs greater than 1, prefixing them with
> >> `unshare --fork -p` to have each one get the same PID as if they were
> >> executed in a container. Each one then only receives a fraction of
> >> the traffic.
> >>
> >> The used UNIQUEID fanout flag is available since Linux v4.12, while DPDK
> >> currently requires Linux v5.4 or newer. The change is also compatible
> >> with RHEL 8.
> >>
> >> Fixes: 364e08f2bbc0 ("af_packet: add PMD for AF_PACKET-based virtual devices")
> >> Cc: stable@dpdk.org
> >>
> >> Signed-off-by: Frank Dressler <frank@dressler.pro>
> >> ---  
> > 
> > Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> > 
> > The commit message is way to long though. Will chop it during merge.  
> 
> Thank you.
> 
> > You need to tell you AI to be concise. I have started using multiple
> > prompts to tell it to not repeat.
> >   
> 
> I did try let AI generate the commit message but it was too short and 
> did not give me the impression that a reader without my context could 
> easily understand and review the issue. So I wrote my own message.
> 
> This is not the first time people think I used AI when I did not. It is 
> always very demotivating. 
> https://github.com/secdev/scapy/issues/4964#issuecomment-6124262531 But 
> I understand when people think things are AI even when they are not 
> given the amount of AI generated content.
> 
> I'll try writing more concise messages in the future.
> 
> > The kernel review prompt includes /kslop skill which has:
> > https://github.com/masoncl/review-prompts/blob/main/kernel/slop-indicators.md
> >   
> 
> It would feel weird applying AI-detection stuff to hand-written commits 
> just to make sure people relying on it do not get confused by such 
> broken tools that lead to miscategorizations.
> 
> > AI even flagged that:
> >   
> 
> I started to run the AI patch review locally a while ago after noticing 
> its horrible quality to prevent sending unnecessary patch versions. When 
> I run it with just `./devtools/ai/review-patch.py <patch>` it says
> 
> 	Error: API error: {'type': 'not_found_error', 'message': 'model: 
> claude-sonnet-4-5-20250929'}
> 
> So I switched it to claude-sonnet-4-6 and that just outputs some very 
> stupid comments that read like "I found a bug. ... Oh, no, it is not a 
> bug. Actually, re-reading the logic carefully ... This is correct. There 
> is one real issue: ... This is correct. No correctness errors found ... 
> Warning: ... No issue. ... No Errors or Warnings found." With 
> claude-opus-5-5 it becomes sane or broken because it just says "No 
> issues found. Review-Result: CLEAN"
> 
> > 
> > Logic is correct. The kernel clears PACKET_FANOUT_FLAG_UNIQUEID from
> > the stored group flags after allocating the id, and PACKET_FANOUT
> > getsockopt returns id | type << 16 | flags << 24, which is exactly
> > the encoding fanout_add() needs for the later queues to pass the
> > match->flags/type checks and join. DEFRAG, ROLLOVER and
> > IGNORE_OUTGOING survive the round trip unchanged.
> > 
> > Info
> > 
> > The commit message is longer than it needs to be. The two git show
> > transcripts repeat what the Fixes: tag already says; dropping them
> > and the "This fix ensures" opener would leave something like:
> > 
> >    The fanout group id was derived from (getpid() ^ ifindex), so
> >    processes in separate pid namespaces sharing a netns (e.g. a k8s
> >    pod) can pick the same id. Their queues then join one fanout group
> >    and each process sees only part of the traffic.
> > 
> >    Use PACKET_FANOUT_FLAG_UNIQUEID on the first queue so the kernel
> >    allocates an unused id, then read it back with getsockopt and use
> >    it for the remaining queues.
> > 
> >    PACKET_FANOUT_FLAG_UNIQUEID is available since Linux 4.12.
> > 
> > Worth one sentence: this also fixes two af_packet vdevs on the same
> > interface in one process, which previously shared a group because
> > pid and ifindex were identical.  
> 
> 
> How do I reproduce this output? Is it created with the review-patch.py tool?
> 

Mostly I am trying to suppress the over wording AI does.
Especially in comments.
AI seems to generate a PhD thesis for a one line bug report
