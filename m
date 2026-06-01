Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B21CD6E56
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 12:40:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 640294025F;
	Mon,  1 Jun 2026 14:40:11 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id D99114025A
 for <dev@dpdk.org>; Mon,  1 Jun 2026 14:40:09 +0200 (CEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id EDC7C1D00430;
 Mon,  1 Jun 2026 08:40:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 01 Jun 2026 08:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1780317608;
 x=1780404008; bh=q9LhhxS8AO8jP9buzd8XGFYZ9BlxR0W1NQati87Me3k=; b=
 Pr1Ua/J0MLLtHsOSw76P5lXFq8wo3taOEl/DmDeRlphqFEzkBel/xKV3PWymlolu
 RAkL6/oH03hK5IB8ifse1c8vxSc79wocE/ht4xNmm/MGxS96+0/uueTrT+4gHHDy
 JihqHrBGnU44LWhCNYUkZMItoBiMimXjg7OexSH1lZ/4tgGqRRzbWSbxR0BsdBsE
 gaYtngmXHPWUaDZ+c/A/JwE4oCLvslJzccdRZnEB+PAPtCSj6oHt05nPx6zuryev
 JmnSWEqYpIxheoOhCqTVhnikP2C85pXTaTdil8NhdWJn9mSK02VPiWjiG7bCgiak
 C9jYS51Ne5wJpTltIUgEgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780317608; x=
 1780404008; bh=q9LhhxS8AO8jP9buzd8XGFYZ9BlxR0W1NQati87Me3k=; b=i
 2FE8fKBTPQuWMyGqVUDXTP8phfI330M5xnDbZvn6btyXpYCmnBK9/FaKJgMbXEhv
 vBQAio/X6QXKpLSqVLWo+WqlZ5iqpSXks6Vc2RWyxrX+6458xdUz+HFfqRN+SCLB
 Hczi4v6aOCYeMwEk9rlqVjvIQhSrmlS+rJFnn/FUw8YbmhwaZoSxLdPnfjc3e66m
 5E0IATmZ6ys3a8ZupMbZLNlh04oA1fc27HeyVicAxS52kuWgPFX8iHu0ea4JJNhM
 ez0tNzk4wOwR0czcfcA2NNGX2IHESNYuMuoZUTAj1lA5pmsRZ4J+VTV3rTw54fLy
 vd6A7JTiBu82JntxdZN4w==
X-ME-Sender: <xms:qH0dapgoBsZnc4wcv9iRLeM2M4sSGF6tPT-eSZPYS2vIigWqvNJK9Q>
 <xme:qH0daiXEz7LwqMdvVAqN1qLJkwQzdydIzcpQm6gUMPpfkhFToxBTv7DPPT45MMqjU
 4sD3rTqd-GXHmpQhaUVuJWIlydXB_jJnRNmYN94WFkvfalNxjeiXQ>
X-ME-Received: <xmr:qH0daoN0YJA2JktUVKa6o7hdx7j5STopaZzGeD8UIl-UhcaajUIyUJjB0j-6Dn-ynyqycuzDXV5uRVMfrw-2cvLUfg>
X-ME-Proxy-Cause: dmFkZTF4cMcFGsyCUrYSxnNPiO8j2WUCXAHowHp64tBdQ/i2z+aO2/QeMLWUqEiz2jK02Y
 GDvUD8hyAp/PNytUTLBBGVyoHwvd8w/EpCyY2NM0sWHpqQ7BfVuGDKDopb6Rx5qqpi7jfy
 E45b5yd0f3ljFIKkm+gff0l20MrRh0aB6uoaKWwFWAE0SkRkvOLdR3D/1cKCYTwHcV6cuo
 FgwoaIfmBTHLZSln2mTRW7g9jWRA091lYmjHpOcPgwyfVQf1A1bq16K5FuFNEhpsiTIzKz
 JB7DQggDfg3EUQjI1buU3ySultzBlONPtoj40OxaxkwooLNimsT5I29IMgsNW9MfiH6ceR
 FYtvpgdDFNYKeubOhsjRTQoF/AqEPYPWminmuVvymvylDW7iLiBs6YRXe8VMBH6v94O4Gs
 HjFHZx2PKx31FS37fExKapwXiNRWppepVxn0C+8aaIV/NKI2qLa8tJh+O0zcx9XuxqR8AZ
 4CjHMbPY4p1MLIe4xJTzwvkbYG4p+b5/4pw2fainIWPmyrC6q1MajjAGCIHPKs2deX6pDM
 nbIJsj7WFog3NMnWtZn2XzokLeZbZH88G4M267Kz+jH/rvPNn4Vh8JFd6jMn4iRUK7ZL9K
 TKPF80FU+xcYe6jUjSDa33OcZCr2O0wlhZaZUxvLWSK3CwTsmQTai2F9esmA
X-ME-Proxy: <xmx:qH0damZFVdbNgWhFPVIHsTeOuyVmZc5yaEG7aK2B6v4OXvML1iaC_A>
 <xmx:qH0daso4LoGOOLwBKwq4VzPl8zE9RUeMV8StOYguB17yoYZK68MmOw>
 <xmx:qH0daqYttvZGcNV50O0rlxoEuGct65nMZvkvShYQkomCGxC0eIrLFQ>
 <xmx:qH0dakQP_it5LKjlOtzRk6j7j4mwuLGZ3y0HXFhfwDeGlqRZ3BjTKQ>
 <xmx:qH0daqBsMbMluQrJzC-O3NQGUIxQiCXFQwmLQLrZPRiF1TuR7M2SOTJv>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:40:07 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Jianfeng Tan <jianfeng.tan@intel.com>
Subject: Re: [PATCH v2 2/5] eal: fix async IPC callback not fired when no peers
Date: Mon, 01 Jun 2026 14:40:06 +0200
Message-ID: <FGTuNPDMQtmtEID8twKsTA@monjalon.net>
In-Reply-To: <n2qqs3VCRg2oTV_S-0kNSw@monjalon.net>
References: <1ad014dd239fa1e8ea62aab7e56a7bf7264c04ff.1780068382.git.anatoly.burakov@intel.com>
 <n2qqs3VCRg2oTV_S-0kNSw@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

01/06/2026 14:21, Thomas Monjalon:
> 29/05/2026 17:26, Anatoly Burakov:
> > Currently, when rte_mp_request_async() is called and no peer processes
> > are connected (nb_sent == 0), the user callback is never invoked.
> > 
> > The original implementation used a dedicated background thread and
> > pthread_cond_signal() to wake it after queuing the dummy request. When
> > that thread was replaced with per-message alarms, no alarm was set for
> > the dummy request, silently breaking the nb_sent == 0 path.
> > 
> > This was not noticed because async requests are used while handling
> > secondary process requests, where peers are typically already present.
> > 
> > Fix it by setting a 1us alarm on the dummy request, so the callback path
> > immediately triggers and processes it.
> > 
> > Fixes: daf9bfca717e ("ipc: remove thread for async requests")
> > Cc: stable@dpdk.org
> > 
> > Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> > ---
> >  lib/eal/common/eal_common_proc.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
> > index 799c6e81b0..0ec79336a5 100644
> > --- a/lib/eal/common/eal_common_proc.c
> > +++ b/lib/eal/common/eal_common_proc.c
> > @@ -1187,11 +1187,15 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
> >  	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
> >  		ret = mp_request_async(eal_mp_socket_path(), copy, param, ts);
> >  
> > -		/* if we didn't send anything, put dummy request on the queue */
> > +		/* if we didn't send anything, put dummy request on the queue
> > +		 * and set a minimum-delay alarm so the callback fires immediately.
> > +		 */
> >  		if (ret == 0 && reply->nb_sent == 0) {
> >  			TAILQ_INSERT_TAIL(&pending_requests.requests, dummy,
> >  					next);
> >  			dummy_used = true;
> > +			if (rte_eal_alarm_set(1, async_reply_handle, dummy) < 0)
> > +				EAL_LOG(ERR, "Fail to set alarm for dummy request");
> 
> Shouldn't we return an error?

AI suggests this:

      if (rte_eal_alarm_set(1, async_reply_handle,
              (void *)(uintptr_t)dummy->id) < 0) {
          EAL_LOG(ERR, "Fail to set alarm for dummy request");
          TAILQ_REMOVE(&pending_requests.requests, dummy, next);
          dummy_used = false;
          ret = -1;
      }


