Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD346C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 13:30:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08FCA402DA;
	Wed,  9 Jul 2025 15:30:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E1295402A9
 for <dev@dpdk.org>; Wed,  9 Jul 2025 15:30:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752067849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Se2bTKd1JGJV6JIInKMCJMYu0NDnZqZf7l/OQwe4xgY=;
 b=MeV1h2uBBMxwkgAQoRgcS6yOLxx6svM3V2aO94P4d+Bm4oFkOKA5xq5wBrBu8tE7CNuhkV
 X6UNwKX/TzzL4P4b79B/rKOdAqVhx6q5lY7yaMpYzTun70mqRrYOcC4xOhEnay10Rlo169
 yblS5RZBPgwDH5KyKfNGB/LZJKudyLg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-vk8fL9TJMbiUqE7kzUtTEg-1; Wed,
 09 Jul 2025 09:30:48 -0400
X-MC-Unique: vk8fL9TJMbiUqE7kzUtTEg-1
X-Mimecast-MFC-AGG-ID: vk8fL9TJMbiUqE7kzUtTEg_1752067846
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE36A180028F; Wed,  9 Jul 2025 13:30:45 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.100])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16B7A18046C7; Wed,  9 Jul 2025 13:30:43 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jerin Jacob <jerinjacobk@gmail.com>
Cc: Ori Kam <orika@nvidia.com>,  Jerin Jacob <jerinj@marvell.com>,  dev
 <dev@dpdk.org>,  "techboard@dpdk.org" <techboard@dpdk.org>, David Marchand
 <dmarchan@redhat.com>
Subject: Re: Proposal: AI-Based Code Review for DPDK
In-Reply-To: <f7th5zusrla.fsf@redhat.com> (Aaron Conole's message of "Wed, 02
 Jul 2025 08:30:09 -0400")
References: <BY3PR18MB478574FF76D2777FFACB1B00C877A@BY3PR18MB4785.namprd18.prod.outlook.com>
 <ccab20d4-8620-407c-b7a9-de5b81c4d6e8@nvidia.com>
 <CALBAE1MTeqJKGy1EzXV1oCq2SxmN-Y4fm4LwwkAwcHbDy_2w3Q@mail.gmail.com>
 <f7th5zusrla.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 09 Jul 2025 09:30:42 -0400
Message-ID: <f7t7c0hqynx.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wN6Qc8lJEGS7ANirVWDtxgtQbYyrSgqWe24VudqUgT8_1752067846
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

Aaron Conole <aconole@redhat.com> writes:

> Jerin Jacob <jerinjacobk@gmail.com> writes:
>
>> On Thu, Jun 19, 2025 at 7:42=E2=80=AFPM Ori Kam <orika@nvidia.com> wrote=
:
>>>
>>>
>>> Nice idea,
>>> Some comments:
>>>
>>>
>>> 1. The first link is broken for me.
>>
>> Yes.  https://github.com/DPDK/dpdk-ai-code-review is the proposed name
>> of the repository. It is not created yet.
>
> I guess we need this created by someone (but I don't know who should be
> the contact).

Cc'd David

Is it possible to create this repository?  I guess this is the first step.

>>>
>>> 2. I like the idea that there is a separate GitHub repository. If I
>>>     understand correctly the new repository is a clone of the main one,
>>>     and only used by the bot is that correct?
>>
>> Yes.
>>
>>>
>>> 3. I think main usage is also for the reviewer, just like in your examp=
le.
>>
>> Yes
>>
>>>
>>> 4. The only thing I=E2=80=99m missing is that there is no =E2=80=9Cpers=
onal touch=E2=80=9D
>>>     meaning that each reviewer puts emphasis on different things. It wi=
ll
>>>     be great if the AI can learn from previous reviews of the reviewer
>>>     and add review accordingly.
>>
>> Yes. However, It looks like https://docs.sourcery.ai/Code-Review/ dont
>> have that feature.
>>
>>>
>>> 5. It will also be great if the AI could target people who may be
>>>     interested in this patch.  And send them some notification or tell
>>>     the developer to add them in the to
>
> Yes, well - not everyone will be on GitHub.  But the idea / plan from my
> side was to try and get the comments associated with the specific hunks
> and reply to the patch (and all the folks CC'd) with the comments.  At
> the very least, we can send the pull request URL and reply with that.
>
>> Good input.
>>
>>
>> Adding @Aaron Conole . He has some plans to implement this workflow.
>
> Yes - the pull-request submission side is probably fairly simple to
> implement.
>
> But I need to look at monitoring the pull requests.

I looked briefly at this, and it seems like we should be able to do
something with a JS like (just mocking it up):

  curl -L -X POST \
       <GITHUB HEADERS>
       https://api.github.com/repos/DPDK/dpdk-ai-code-review/pulls \
       '{"title":"Series AI review - <SERIES DETAILS>", "body":"<cover
       letter / commit message>",
       "head":"ovsrobot/dpdk:series_SERIESID",
       "base":"main"
       }'

That tells us the pull request ID in the response, and we can then
monitor it and pull the review comments.  I haven't written up a script
suite for it, but it looks fairly straightforward.

>>>
>>> Best,
>>> Ori
>>>
>>> On 13/06/2025 13:03, Jerin Jacob wrote:
>>> >
>>> > Goals
>>> > -------
>>> >
>>> > # Leverage modern AI-powered code review tools to accelerate and
>>> > supplement human review efforts.
>>> > # Prevent AI-generated comments from cluttering the mailing list
>>> > or polluting the main DPDK GitHub repository.
>>> >
>>> > Setup
>>> > -------
>>> >
>>> > # Create a dedicated repository:
>>> > Set up a new repository, for example:
>>> > https://github.com/DPDK/dpdk-ai-code-review, under the official
>>> > DPDK GitHub organization.
>>> > This ensures that AI-generated pull requests do not interfere with
>>> > the main repository (https://github.com/DPDK/dpdk).
>>> >
>>> > # Select an AI review tool:
>>> > Use a free, open-source-friendly AI code review service.
>>> > One potential candidate is Sourcery: https://sourcery.ai/pricing
>>> >
>>> > # Connect the tool:
>>> > Integrate Sourcery with the new repository via:
>>> > https://app.sourcery.ai/?product=3Dprod_opensource
>>> >
>>> > # Trigger AI reviews:
>>> > Once integrated, any pull request to this repository will
>>> > automatically trigger a code review by the AI tool.
>>> > Example of a test PR reviewed by the AI bot:
>>> > https://github.com/MarvellEmbeddedProcessors/dao/pull/2
>>> >
>>> > Workflow
>>> > -------------
>>> >
>>> > # When a patch is sent to the DPDK mailing list, a bot will
>>> > convert it into a GitHub pull request on the dpdk-ai-code-review
>>> > repository.
>>> > # The AI tool will review the pull request and leave comments
>>> > directly on the PR.
>>> > # Once the AI review is complete, the bot will close the PR and
>>> > share the PR URL:
>>> > - As a comment in Patchwork URL for the given patch
>>> > - With the patch author directly.
>>> > # The author can review the AI-generated comments by visiting the
>>> > PR URL, if they choose to do so.
>>> >
>>> >
>>>

