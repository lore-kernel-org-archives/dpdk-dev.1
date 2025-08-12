Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7835CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 08:31:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 936FE4026A;
	Tue, 12 Aug 2025 10:31:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 5F71140264
 for <dev@dpdk.org>; Tue, 12 Aug 2025 10:31:12 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 853DE2934;
 Tue, 12 Aug 2025 01:31:03 -0700 (PDT)
Received: from [10.57.2.91] (unknown [10.57.2.91])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 368B03F5A1;
 Tue, 12 Aug 2025 01:31:11 -0700 (PDT)
Message-ID: <df1c5f22-4dce-48a1-9152-4e508efd068b@arm.com>
Date: Tue, 12 Aug 2025 09:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] dts: add artifact module
Content-Language: en-GB
To: Patrick Robb <probb@iol.unh.edu>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
References: <20250725151503.87374-1-luca.vizzarro@arm.com>
 <20250725151503.87374-5-luca.vizzarro@arm.com>
 <CAJvnSUAvo4NimU9xVVGY10uGhGDcsQQ-gBbW0QfHS3pANf64pQ@mail.gmail.com>
From: Luca Vizzarro <Luca.Vizzarro@arm.com>
In-Reply-To: <CAJvnSUAvo4NimU9xVVGY10uGhGDcsQQ-gBbW0QfHS3pANf64pQ@mail.gmail.com>
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

On 12/08/2025 02:25, Patrick Robb wrote:
> On Fri, Jul 25, 2025 at 11:15 AM Luca Vizzarro <luca.vizzarro@arm.com 
> <mailto:luca.vizzarro@arm.com>> wrote:
> 
> 
>     +
>     +@overload
>     +def make_file_path(node: Node, file_name: str, custom_path:
>     PurePath | None = None) -> PurePath: ...
>     +
>     +
>     +@overload
>     +def make_file_path(node: None, file_name: str, custom_path:
>     PurePath | None = None) -> Path: ...
>     +
>     +
>     +def make_file_path(
>     +    node: Node | None, file_name: str, custom_path: PurePath | None
>     = None
> 
> 
> Maybe it makes sense to set a default value of None for node? That way 
> people don't have to pass in None every time they want to make a path on 
> the DTS engine system.

Even though this function is not private, ideally we don't want this to 
be used outside of the artifact module. But we want the Artifact class 
to be used instead. For this reason the node argument is kept without a 
default to match the behaviour of the Artifact constructor.

Could just make this private.

>     +    def open(
>     +        self, file_mode: BinaryMode | TextMode = "rb", buffering:
>     int = -1
>     +    ) -> Union["ArtifactFile", TextIOWrapper]:
>     +        """Open the artifact file.
>     +
>     +        Args:
>     +            file_mode: The mode of file opening.
>     +            buffering: The size of the buffer to use. If -1, the
>     default buffer size is used.
>     +
>     +        Returns:
>     +            An instance of :class:`ArtifactFile`
>     or :class:`TextIOWrapper`.
>     +        """
>     +        if self._fd is not None and not self._fd.closed:
>     +            self._logger.warning(
>     +                f"Artifact {self.path} is already open. Closing the
>     previous file descriptor."
>     +            )
>     +            self._fd.close()
>     +        elif not self._directories_created:
>     +            self.mkdir()
>     +
>     +        # SFTPFile does not support text mode, therefore everything
>     needs to be handled as binary.
>     +        if "t" in file_mode:
>     +            actual_mode = cast(BinaryMode, cast(str,
>     file_mode).replace("t", "") + "b")
> 
> 
> Is it worth logging this event to prevent confusion? (where we change 
> the requested mode to binary mode)
This is an implementation-related internal detail. At a higher level, 
where the user and test writer are interested, the mode is the same as 
specific in `mode`. The only reason why this is happening is because the 
lower level implementation works in binary mode only. Text mode (in 
standard Python too) is just an encoder/decoder wrapper as used here. 
Under the hood all the file operations are done in binary mode.

A user shouldn't be concerned about how it works internally. Quite the 
opposite, introducing logging for this kind of thing will introduce 
confusion. The user should only care about the higher level 
functionality, which is the API.

Please let me know if it's not clear.
