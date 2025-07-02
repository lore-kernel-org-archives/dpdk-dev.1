Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AECC8303F
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 12:30:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3ECE3402E8;
	Wed,  2 Jul 2025 14:30:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1826D402A0
 for <dev@dpdk.org>; Wed,  2 Jul 2025 14:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751459419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uO7VYUeoUYblrAhAUbbvk1bc1pMU+U/R/HWLoZApZ74=;
 b=TF7qDhelQpiybdXG6s8IODCNtMJLQ0q3V0JYa6ho/n3cuqXfoWCk/bvWppYvUVToHv6H9D
 zDfNunUjAcTae0ue56xGTodIjOMIP5sEuo6ch5bsd0RYqF6bxT9FyO+P/xu/5+C2sPQPsj
 yVZuuy6paiqpGsVw/GIH7ByVhseoWIg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-A19cQ_jzPgm5ABk74wdvdA-1; Wed,
 02 Jul 2025 08:30:14 -0400
X-MC-Unique: A19cQ_jzPgm5ABk74wdvdA-1
X-Mimecast-MFC-AGG-ID: A19cQ_jzPgm5ABk74wdvdA_1751459412
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 892281801207; Wed,  2 Jul 2025 12:30:12 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.59])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40F7219560AB; Wed,  2 Jul 2025 12:30:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
Cc: Ori Kam <orika@nvidia.com>,  Jerin Jacob <jerinj@marvell.com>,  dev
 <dev@dpdk.org>,  "techboard@dpdk.org" <techboard@dpdk.org>
Subject: Re: Proposal: AI-Based Code Review for DPDK
In-Reply-To: <CALBAE1MTeqJKGy1EzXV1oCq2SxmN-Y4fm4LwwkAwcHbDy_2w3Q@mail.gmail.com>
 (Jerin Jacob's message of "Fri, 27 Jun 2025 13:31:03 +0530")
References: <BY3PR18MB478574FF76D2777FFACB1B00C877A@BY3PR18MB4785.namprd18.prod.outlook.com>
 <ccab20d4-8620-407c-b7a9-de5b81c4d6e8@nvidia.com>
 <CALBAE1MTeqJKGy1EzXV1oCq2SxmN-Y4fm4LwwkAwcHbDy_2w3Q@mail.gmail.com>
Date: Wed, 02 Jul 2025 08:30:09 -0400
Message-ID: <f7th5zusrla.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vXY_FDk1Ab_QyxlFjo_foZxF7LzECfggiLQuATZnzqo_1751459412
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Jerin Jacob <jerinjacobk@gmail.com> writes:

> On Thu, Jun 19, 2025 at 7:42=E2=80=AFPM Ori Kam <orika@nvidia.com> wrote:
>>
>>
>> Nice idea,
>> Some comments:
>>
>>
>> 1. The first link is broken for me.
>
> Yes.  https://github.com/DPDK/dpdk-ai-code-review is the proposed name
> of the repository. It is not created yet.

I guess we need this created by someone (but I don't know who should be
the contact).

>>
>> 2. I like the idea that there is a separate GitHub repository. If I
>>     understand correctly the new repository is a clone of the main one,
>>     and only used by the bot is that correct?
>
> Yes.
>
>>
>> 3. I think main usage is also for the reviewer, just like in your exampl=
e.
>
> Yes
>
>>
>> 4. The only thing I=E2=80=99m missing is that there is no =E2=80=9Cperso=
nal touch=E2=80=9D
>>     meaning that each reviewer puts emphasis on different things. It wil=
l
>>     be great if the AI can learn from previous reviews of the reviewer
>>     and add review accordingly.
>
> Yes. However, It looks like https://docs.sourcery.ai/Code-Review/ dont
> have that feature.
>
>>
>> 5. It will also be great if the AI could target people who may be
>>     interested in this patch.  And send them some notification or tell
>>     the developer to add them in the to

Yes, well - not everyone will be on GitHub.  But the idea / plan from my
side was to try and get the comments associated with the specific hunks
and reply to the patch (and all the folks CC'd) with the comments.  At
the very least, we can send the pull request URL and reply with that.

> Good input.
>
>
> Adding @Aaron Conole . He has some plans to implement this workflow.

Yes - the pull-request submission side is probably fairly simple to
implement.

But I need to look at monitoring the pull requests.

>>
>> Best,
>> Ori
>>
>> On 13/06/2025 13:03, Jerin Jacob wrote:
>> >
>> > Goals
>> > -------
>> >
>> > # Leverage modern AI-powered code review tools to accelerate and
>> > supplement human review efforts.
>> > # Prevent AI-generated comments from cluttering the mailing list
>> > or polluting the main DPDK GitHub repository.
>> >
>> > Setup
>> > -------
>> >
>> > # Create a dedicated repository:
>> > Set up a new repository, for example:
>> > https://github.com/DPDK/dpdk-ai-code-review, under the official
>> > DPDK GitHub organization.
>> > This ensures that AI-generated pull requests do not interfere with
>> > the main repository (https://github.com/DPDK/dpdk).
>> >
>> > # Select an AI review tool:
>> > Use a free, open-source-friendly AI code review service.
>> > One potential candidate is Sourcery: https://sourcery.ai/pricing
>> >
>> > # Connect the tool:
>> > Integrate Sourcery with the new repository via:
>> > https://app.sourcery.ai/?product=3Dprod_opensource
>> >
>> > # Trigger AI reviews:
>> > Once integrated, any pull request to this repository will
>> > automatically trigger a code review by the AI tool.
>> > Example of a test PR reviewed by the AI bot:
>> > https://github.com/MarvellEmbeddedProcessors/dao/pull/2
>> >
>> > Workflow
>> > -------------
>> >
>> > # When a patch is sent to the DPDK mailing list, a bot will
>> > convert it into a GitHub pull request on the dpdk-ai-code-review
>> > repository.
>> > # The AI tool will review the pull request and leave comments
>> > directly on the PR.
>> > # Once the AI review is complete, the bot will close the PR and
>> > share the PR URL:
>> > - As a comment in Patchwork URL for the given patch
>> > - With the patch author directly.
>> > # The author can review the AI-generated comments by visiting the
>> > PR URL, if they choose to do so.
>> >
>> >
>>

