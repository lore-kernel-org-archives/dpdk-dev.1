Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F2C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 19:45:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15252402A3;
	Tue, 18 Feb 2025 20:45:54 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 260F340264
 for <dev@dpdk.org>; Tue, 18 Feb 2025 20:45:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739907952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OIDAxaqXYVKgm+iNxZCqsCNC38jDMkbbdg0/WPhb2dc=;
 b=c8QJGUABrrX/Y856AhwQRxLy6XkPAaO0ncDwWV6mLBvdQ+BP9Nb6qvKrz9teKXA9GhDWdy
 X324p/tV638QxCrJKs7whcwvY2/ch5FMQnHu5DDnzufkUp60nJd6d8ONmp4IsUsLh23F+a
 nm3KKV/+oxpxg3uSiK4ZhuOJwcxY0k4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-psqoyVd3P7mHW57u3GOAfQ-1; Tue,
 18 Feb 2025 14:45:51 -0500
X-MC-Unique: psqoyVd3P7mHW57u3GOAfQ-1
X-Mimecast-MFC-AGG-ID: psqoyVd3P7mHW57u3GOAfQ_1739907950
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8E641800879; Tue, 18 Feb 2025 19:45:49 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.80.189])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D7D91800359; Tue, 18 Feb 2025 19:45:47 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org,  thomas@monjalon.net,  andremue@linux.microsoft.com,
 Michael Santana <maicolgabriel@hotmail.com>
Subject: Re: [PATCH] ci: build with MSVC in GHA
In-Reply-To: <CAJFAV8zuMwzA6mPxzPsk3d5OHjYu3vVjHtTzwODjxDmm7aJAKg@mail.gmail.com>
 (David Marchand's message of "Tue, 18 Feb 2025 15:10:13 +0100")
References: <20250213075010.2670431-1-david.marchand@redhat.com>
 <f7teczvbcph.fsf@redhat.com>
 <CAJFAV8zuMwzA6mPxzPsk3d5OHjYu3vVjHtTzwODjxDmm7aJAKg@mail.gmail.com>
Date: Tue, 18 Feb 2025 14:45:45 -0500
Message-ID: <f7t7c5n9guu.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vm17EtJmEIeYGdt3Ehp4rVUMu33S18WatOFMAm10_oU_1739907950
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

David Marchand <david.marchand@redhat.com> writes:

> On Tue, Feb 18, 2025 at 2:32=E2=80=AFPM Aaron Conole <aconole@redhat.com>=
 wrote:
>>
>> David Marchand <david.marchand@redhat.com> writes:
>>
>> > Add a build target in Windows 2022 for MSVC.
>> >
>> > Loading MSVC environment and having successive commands in a single
>> > (cmd or pwsh) shell does not seem to correctly report if one of the
>> > commands failed.
>> > For now, load MSVC environment and run commands in separate shells.
>> >
>> > Signed-off-by: David Marchand <david.marchand@redhat.com>
>> > ---
>>
>> LGTM.
>>
>> Acked-by: Aaron Conole <aconole@redhat.com>
>>
>> How far back will this work (ie: can we backport this to older branches?=
)
>
> MSVC was added in 23.11.
> The patch applies cleanly and runs on 23.11 (where only lib/kvargs,
> lib/log and lib/telemetry are compiled) and 24.11.
>
> I can add Cc: stable if you think it is worth having it in LTS (UNH
> provides some coverage in LTS releases).

I usually prefer to back-port CI related changes because it helps us
catch issues / improve the stable release cycle.

