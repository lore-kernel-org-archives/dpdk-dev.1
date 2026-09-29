Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF9CA5FA7
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:26:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 340F5402A2;
	Tue, 29 Sep 2026 21:26:35 +0200 (CEST)
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net
 [37.230.175.128])
 by mails.dpdk.org (Postfix) with ESMTP id EF1D440290
 for <dev@dpdk.org>; Tue, 29 Sep 2026 21:26:33 +0200 (CEST)
Received: from mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:2310:0:640:2452:0])
 by forward500b.mail.yandex.net (postfix) with ESMTPS id 3F5D6C013D;
 Tue, 29 Sep 2026 22:26:33 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id UQo4mt1nEuQ0-YJyaMQns; 
 Tue, 29 Sep 2026 22:26:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1790709992; bh=XrxIUqqvQ0sqUgI/VyK8LAi3KoKy669e9b1gIx1LCmk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=p+0sE9XbkACQ4hT5cRXEYf3/fAFuE0VmzbNhsmvtFXWjDWZSia5ZWfijwkBboteKV
 VCvUeF1SpleNeOMqFKAvaxCg02azSklBd+uy6WHP0LBi2HjLDQ07Q+2gFz6Am0bLO3
 N7LhCsNEos7Nz0mLDZBuNRleosmBBDiFyZKQGp5U=
Authentication-Results: mail-nwsmtp-smtp-production-main-71.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Message-ID: <34d8b67c-dd88-4417-8836-983aa3e6cc72@yandex.ru>
Date: Tue, 29 Sep 2026 20:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] mbuf: add optional no-copy dynamic field storage
To: "Randy Tice (rtice)" <rtice@cisco.com>,
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>,
 "dev@dpdk.org" <dev@dpdk.org>
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Harman Kalra <hkalra@marvell.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <179036466858.2.13982499480648014088.v2-0000-cover-letter.patch@cisco.com>
 <179061941387.2.17741463412422386825.v3-0000-cover-letter.patch@cisco.com>
 <179061941387.2.13690688541375502570.v3-0001-mbuf-add-optional-no-copy-dynamic-field-storage.patch@cisco.com>
 <3732a4ac-a585-4bb6-b08a-2b3dab6b782a@yandex.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65A87@smartserver.smartshare.dk>
 <4b426d5e-d141-486a-b9e1-acd85c260507@yandex.ru>
 <98CBD80474FA8B44BF855DF32C47DC35F65A88@smartserver.smartshare.dk>
 <89369203-bdf0-4b15-899b-c529b402ff85@yandex.ru>
 <PH0PR11MB761617C6B4A1F1A1AC81BDD8A98C2@PH0PR11MB7616.namprd11.prod.outlook.com>
Content-Language: en-US, ru
From: Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
In-Reply-To: <PH0PR11MB761617C6B4A1F1A1AC81BDD8A98C2@PH0PR11MB7616.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Hi Randy.
>   Hi all,
>
>   Thanks for the discussion. We are now where I had hoped we’d get to 
> during
>   RFC but we are here.
>
>   Konstantin, I understand your concern about making sizeof(struct 
> rte_mbuf)
>   depend on a build-time option. That can create different mbuf 
> layouts between
>   DPDK builds that otherwise present the same ABI/version, which is 
> not a good
>   property for a core public structure.
>
>   After thinking through this again, I think the current patch may be 
> trying too
>   hard to make this a dynamic-field allocator feature. The actual 
> requirement is
>   simpler: a fixed global per-mbuf metadata area that is present in every
>   pktmbuf object, separate from ordinary application private data, and not
>   copied by mbuf copy/clone helpers.
>
>   The mbuf structure change would look roughly like this:
>
>    struct rte_mbuf {
>           ...
>           uint32_t dynfield1[9]; /**< Reserved for dynamic fields. */
>   +
>   +       alignas(RTE_CACHE_LINE_SIZE)
>   +       uint8_t metadata[];
>   +       /**< Optional cache-line-aligned per-mbuf metadata area. */
>    };
>
>   Since this is a flexible array member, it does not change sizeof(struct
>   rte_mbuf). The object layout would become:
>
>   struct rte_mbuf fixed header
>   global per-mbuf metadata area
>   application private data
>   packet data buffer
>
>   With that layout, this could be sized at EAL init time rather than 
> by a build
>   option, for example:
>
>   --mbuf-metadata-size=256
>
Yes, that new proposal looks good to me.
One extra thing: I would like to repeat Morten there:
we probably do need similar mechanism for register/unregister/query that
dynamic metadata layout, as we have for mbuf dynfields now.
Might be we can extend existing mbuf_dynfield API?
or might be we can add a new API specific for this new metadata?
Right now I don't have strong opinion here.
Konstantin
> That avoids creating different DPDK builds with different mbuf struct 
> sizes or
>   different build-time ABI expectations. The configured size would be 
> part of
>   the process/runtime configuration instead of requiring applications,
>   libraries, and package providers to agree on a compile-time define.
>
>   The official mbuf helpers would account for this area before ordinary
>   priv_size, so application private data remains available and does 
> not overlap
>   with the global metadata area.
>
>   This would also avoid changing the existing dynamic-field allocator 
> and copy
>   semantics. The area would not be part of the dynamic-field registry; 
> it would
>   be explicit per-mbuf metadata storage for applications that deliberately
>   enable it.
>
>   That seems to address the main concerns:
>
>   - sizeof(struct rte_mbuf) remains fixed for ABI purposes.
>   - the metadata area is globally present across pktmbuf pools when 
> enabled.
>   - ordinary priv_size remains separate and available.
>   - dynamic-field allocator/copy behavior remains unchanged.
>   - users that do not enable the EAL option pay no extra per-mbuf 
> storage cost.
>   - applications do not need to be built against a different mbuf-size 
> define.
>
>   If this direction is acceptable, I can take a look at what it means in
>   practice for EAL configuration, mbuf layout helpers, pool 
> constructors, and
>   places that currently do direct object-layout math.
>
>   Thanks,
>   -rt
>
> *From: *Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>
> *Date: *Tuesday, September 29, 2026 at 10:14 AM
> *To: *Morten Brørup <mb@smartsharesystems.com>; Randy Tice (rtice) 
> <rtice@cisco.com>; dev@dpdk.org <dev@dpdk.org>
> *Cc: *Bruce Richardson <bruce.richardson@intel.com>; Harman Kalra 
> <hkalra@marvell.com>; Stephen Hemminger <stephen@networkplumber.org>
> *Subject: *Re: [PATCH v3 1/1] mbuf: add optional no-copy dynamic field 
> storage
>
>
>
> >> From: Konstantin Ananyev [mailto:konstantin.v.ananyev@yandex.ru 
> <mailto:konstantin.v.ananyev@yandex.ru>]
> >> Sent: Tuesday, 29 September 2026 15.13
> >>
> >> 29.09.2026 13:44, Morten Brørup пишет:
> >>>> From: Konstantin Ananyev [mailto:konstantin.v.ananyev@yandex.ru 
> <mailto:konstantin.v.ananyev@yandex.ru>]
> >>>> Sent: Tuesday, 29 September 2026 14.00
> >>>>
> >>>> 28.09.2026 19:16, Randy L Tice пишет:
> >>>>> From: Randy L Tice <rtice@cisco.com>
> >>>>> Date: Thu, 03 Sep 2026 09:13:28 -0400
> >>>>>
> >>>>> Add build-time support for optional cache-line-aligned dynamic-
> >> field
> >>>>> storage at the end of struct rte_mbuf.
> >>>>>
> >>>>> The mbuf_dynfield3_size Meson option sets RTE_MBUF_DYNFIELD3_SIZE
> >> in
> >>>>> rte_build_config.h. A non-zero value enables the extra area and
> >> grows
> >>>>> every mbuf by the configured amount.
> >>>> I am strongly opposed to that patch.
> >>>> Inside mbuf we already do have priv_size that allows user to store
> >>>> his/her specific
> >>>> data straight after rte_mbuf in adjacent manner.
> >>>> It worked well so far for many use-cases (including VPP) and I don't
> >>>> see any
> >>>> reason why this is not enough.
> >>>>    From other side - making size of core rte_mbuf configurable at
> >> run-
> >>>> time,
> >>>> will affect DPDK ABI stability in a negative way.
> >>>> Fro my perspective it is much plausible in terms of ABI stability
> >> and
> >>>> predictability
> >>>> to have just one fixed layout for the mbuf.
> >>>> Konstantin
> >>> The private data area (priv_size) is independent per mbuf pool, and
> >> selected at run-time when creating each pool. As Randy explained in the
> >> RFC, this is unavailable for mbuf pools created by other components.
> >>
> >> I think it should be trivial to enforce minimal priv_size across all
> >> mbuf pools what will be obeyed by different components
> >> (as long as they do use rte_pktmbuf_pool_create() and friends):
> >> 1) introduce new EAL parameter 'mbuf-min-priv-size' or so (keep default
> >> as zero)
> >> 2) make rte_pktmbuf_pool_create_by_ops() and
> >> rte_pktmbuf_pool_create_extbuf() to check that input paramter
> >> 'priv_size' GE then value specified by EAL parameter, if so then return
> >> an error.
> > The private data area cannot be used.
> > Let's say one module creates an mbuf pool with priv_size of 8, and 
> uses those 8 bytes,
> > and some second module creates an mbuf pool with priv_size of 16, 
> and uses those 16 bytes.
> >
> > How should a module (or the application) know at which offset to 
> store its private data without overwriting the private data of other 
> modules?
> >
> > The mbuf dynamic field's registry manages centrally where each 
> module should store its own data, and the data is even accessible by 
> other modules (because they can fetch the offset to the data from the 
> registry)
> ok, I see, you need an ability to register/unregister/query layout for
> that private buffer (what we have now for dynfields).
> Then yes, if we'll add an ability to expand mbuf dynfield[] buffer that
> might be useful, and probably will become
> more popular then current 'priv_size' apporach.
> But I believe it shouldn't be a build time option.
> >
> >>> Mbuf dynamic fields are shared across all mbuf pools, and serves the
> >> need with an existing API. So I am strongly in favor of using the mbuf
> >> dynamic fields API for this.
> >>> I agree with Konstantin that it would be optimal if the size of the
> >> added dynfields area was run-time configurable (as an EAL startup
> >> parameter).
> >>> However, such a modification to the mbuf library would also require
> >> that the performance cost in the dataplane is negligible. We don't want
> >> to compromise on mbuf performance for applications not using this new
> >> feature.
> >>> Randy,
> >>> Could you please explore such an approach?
> >>>
> >>> -Morten
>

