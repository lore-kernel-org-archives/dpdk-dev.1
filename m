Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE94C8303F
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 02:31:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 541AF4021E;
	Tue, 26 Aug 2025 04:31:06 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 9C5284021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 04:31:04 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3252e4b0f51so2528745a91.0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 19:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756175464; x=1756780264; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VXCZ5oTQfgQEixBMRvbWta7f3WQXJtHm+aTFD6HSjg0=;
 b=SHmk5Ydhu59KGRDdpH14v9sdLf6GSFBN7RKGOKMz8Eok/3hx6RJFdPMRbxzNnNTU5s
 +Gh539bUkos9jO8HscoLT+LgCwvnyyOSQF99Cy+ODReIdJNO9u6e4ZYHarcqAmPQo47Y
 cyoP/6E68Q+YXav/E87Or0P0rfjuBWIZyXZns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756175464; x=1756780264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VXCZ5oTQfgQEixBMRvbWta7f3WQXJtHm+aTFD6HSjg0=;
 b=bpHs7EDM9RNcM1d8W8B63QfB/U3GBn/NDHmRZd9VpYI73JyoQupOnlTvakSypgiG8x
 xJP3+kkJMYDIWl0+ggrJxEKjaYfAWiGv4cAsVwm/nEzBW8x1JJP7VFKupcsUAOYhYngW
 /wbDktX5rnUbJlnrVagDXcGIbncrFdM44rV7rUFPZuEpXhEY5N/bYShd9OQaqB5v2kM9
 LvhvQ+8LodO6+LJf4ZOLaotpmn+NbzKraWdh8nGxsufgrnupBHishPGgONiNiXyXKmLH
 SA245IPuCzAbVhobP/gcsfqgAyPaQTd0lnECsf4unrzNGUbCP6e5hTIXWuRSmkaNFCUQ
 NjPw==
X-Gm-Message-State: AOJu0YzAJ/Be/4qAJWXBdu5GKEEAUj7xb0mDYWt1syS7yrzfXk6nXUXo
 +euEQpDppZMlti9QsPOgTojSwCv+P57yw764ITRVExC9LqcM0n2j8iwhSKBlqIG6j75q8GXeOrE
 oq7GjLnB6oGqGq54Cmu4qSxVqUriPxOc4E9sy/RNKgsmoYQO4XBqW
X-Gm-Gg: ASbGncuWIjWztLbn3Lxi0luZvLLqpiusLqjqCOI8Tsvhd/jsa2yKxfxMtbUPLlNpbgN
 fSIicSg834o1xEXwX9c9weRHgxmGrQRnyZ8nOLinOQ5C0uauRDsRKJa5I1/SE62gcNJTN84f+C/
 9wReuq97BgBnqWCmEJHPUyP9Mwgtv8KdVp68H3wTXq98tod02Z2mAKM/TV8mxG/IpKsma07xCzn
 EXuS6/pqhBQcnzV9sV8zOKi7gMXEAHws4hzwkg=
X-Google-Smtp-Source: AGHT+IFUT9kz+y5Ek4Z+tkx1il8E1fOhlhMS4EAABEegWd1eCVJe/Q1uXLCMFtxxJnr4Ld/apE/9JRf9xut7eU0yWuc=
X-Received: by 2002:a17:90b:4fca:b0:325:6598:30e0 with SMTP id
 98e67ed59e1d1-3256598350fmr10819021a91.18.1756175463651; Mon, 25 Aug 2025
 19:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250718150404.200096-1-thomas.wilks@arm.com>
 <20250730125859.159185-1-thomas.wilks@arm.com>
 <20250730125859.159185-2-thomas.wilks@arm.com>
In-Reply-To: <20250730125859.159185-2-thomas.wilks@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 25 Aug 2025 22:24:26 -0400
X-Gm-Features: Ac12FXyH-EriC9xEYQPqcbCYwb62VZjAR8FIpP1JQUf2ftuBoUO-keopFF4u4o4
Message-ID: <CAJvnSUCYOFK5fqCkOe4GOw8PzZjA6UzX-Zt5GutciyJoFnvq9Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dts: add RSS functions to testpmd
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Ivan Malov <ivan.malov@arknetworks.am>, 
 Dean Marx <dmarx@iol.unh.edu>, Alex Chapman <alex.chapman@arm.com>
Content-Type: multipart/alternative; boundary="000000000000acaf9f063d3b76d5"
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

--000000000000acaf9f063d3b76d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think this patch looks good. Thanks Thomas and thanks Ivan for your
insights.

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

On Wed, Jul 30, 2025 at 8:59=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com>=
 wrote:

> From: Alex Chapman <alex.chapman@arm.com>
>
> This patch adds the required functionality for the RSS key_update,
> RETA, and hash test suites. This includes:
> The setting of custom RETA values for routing packets to specific
> queues.
> The setting of the RSS mode on all ports, to specify how to hash
> the packets.
> The updating of the RSS hash key used during the hashing process.
>
> Alongside this, there is the addition of a __str__ method to the
> RSSOffloadTypesFlags class, so that when flag names are cast to
> a string they will use '-' as separators, instead of '_'.
> This allows them to be directly used within testpmd RSS commands
> without any further changes.
>
> Signed-off-by: Alex Chapman <alex.chapman@arm.com>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> Reviewed-by: Patrick Robb <probb@iol.unh.edu>
> Tested-by: Patrick Robb <probb@iol.unh.edu>
> ---
>  dts/framework/remote_session/testpmd_shell.py | 104 ++++++++++++++++--
>  1 file changed, 97 insertions(+), 7 deletions(-)
>
> diff --git a/dts/framework/remote_session/testpmd_shell.py
> b/dts/framework/remote_session/testpmd_shell.py
> index ad8cb273dc..473333f8fb 100644
> --- a/dts/framework/remote_session/testpmd_shell.py
> +++ b/dts/framework/remote_session/testpmd_shell.py
> @@ -343,6 +343,12 @@ def make_parser(cls) -> ParserFn:
>              RSSOffloadTypesFlag.from_list_string,
>          )
>
> +    def __str__(self):
> +        """Replaces underscores with hyphens to produce valid testpmd
> value."""
> +        if self.name is None:
> +            return ""
> +        return self.name.replace("_", "-")
> +
>
>  class DeviceCapabilitiesFlag(Flag):
>      """Flag representing the device capabilities."""
> @@ -644,11 +650,13 @@ class TestPmdPort(TextParser):
>      )
>      #: Maximum number of VFs
>      max_vfs_num: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Maximum number =
of
> VFs: (\d+)")
> +        default=3DNone,
> +        metadata=3DTextParser.find_int(r"Maximum number of VFs: (\d+)"),
>      )
>      #: Maximum number of VMDq pools
>      max_vmdq_pools_num: int | None =3D field(
> -        default=3DNone, metadata=3DTextParser.find_int(r"Maximum number =
of
> VMDq pools: (\d+)")
> +        default=3DNone,
> +        metadata=3DTextParser.find_int(r"Maximum number of VMDq pools:
> (\d+)"),
>      )
>
>      #:
> @@ -1734,6 +1742,82 @@ def close_all_ports(self, verify: bool =3D True) -=
>
> None:
>              if not all(f"Port {p_id} is closed" in port_close_output for
> p_id in range(num_ports)):
>                  raise InteractiveCommandExecutionError("Ports were not
> closed successfully.")
>
> +    def port_config_rss_reta(
> +        self, port_id: int, hash_index: int, queue_id: int, verify: bool
> =3D True
> +    ) -> None:
> +        """Configure a port's RSS redirection table.
> +
> +        Args:
> +            port_id: The port where the redirection table will be
> configured.
> +            hash_index: The index into the redirection table associated
> with the destination queue.
> +            queue_id: The destination queue of the packet.
> +            verify: If :data:`True`, verifies if a port's redirection
> table
> +                was correctly configured.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> +                Testpmd failed to config RSS reta.
> +        """
> +        out =3D self.send_command(f"port config {port_id} rss reta
> ({hash_index},{queue_id})")
> +        if verify:
> +            if f"The reta size of port {port_id} is" not in out:
> +                self._logger.debug(f"Failed to config RSS reta: \n{out}"=
)
> +                raise InteractiveCommandExecutionError("Testpmd failed t=
o
> config RSS reta.")
> +
> +    def port_config_all_rss_offload_type(
> +        self, flag: RSSOffloadTypesFlag, verify: bool =3D True
> +    ) -> None:
> +        """Set the RSS mode on all ports.
> +
> +        Args:
> +            flag: The RSS iptype all ports will be configured to.
> +            verify: If :data:`True`, it verifies if all ports RSS offloa=
d
> type
> +                was correctly configured.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> +                Testpmd failed to config the RSS mode on all ports.
> +        """
> +        out =3D self.send_command(f"port config all rss {flag.name}")
> +        if verify:
> +            if "error" in out:
> +                self._logger.debug(f"Failed to config the RSS mode on al=
l
> ports: \n{out}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Testpmd failed to change RSS mode to {flag.name}"
> +                )
> +
> +    def port_config_rss_hash_key(
> +        self,
> +        port_id: int,
> +        offload_type: RSSOffloadTypesFlag,
> +        hex_str: str,
> +        verify: bool =3D True,
> +    ) -> str:
> +        """Sets the RSS hash key for the specified port.
> +
> +        Args:
> +            port_id: The port that will have the hash key applied to.
> +            offload_type: The offload type the hash key will be applied
> to.
> +            hex_str: The hash key to set.
> +            verify: If :data:`True`, verify that RSS has the key.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If `verify` is :data:`True=
`
> +                Testpmd failed to set the RSS hash key.
> +        """
> +        output =3D self.send_command(
> +            f"port config {port_id} rss-hash-key {offload_type}
> {hex_str}",
> +            skip_first_line=3DTrue,
> +        )
> +
> +        if verify:
> +            if output.strip():
> +                self._logger.debug(f"Failed to set rss hash key:
> \n{output}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Testpmd failed to set {hex_str} on {port_id} with =
a
> flag of {offload_type}."
> +                )
> +        return output
> +
>      def show_port_info_all(self) -> list[TestPmdPort]:
>          """Returns the information of all the ports.
>
> @@ -1952,22 +2036,28 @@ def csum_set_hw(
>
> {port_id}:\n{csum_output}"""
>                      )
>
> -    def flow_create(self, flow_rule: FlowRule, port_id: int) -> int:
> +    def flow_create(self, flow_rule: FlowRule, port_id: int, verify: boo=
l
> =3D True) -> int:
>          """Creates a flow rule in the testpmd session.
>
> -        This command is implicitly verified as needed to return the
> created flow rule id.
> -
>          Args:
>              flow_rule: :class:`FlowRule` object used for creating testpm=
d
> flow rule.
>              port_id: Integer representing the port to use.
> +            verify: If :data:`True`, the output of the command is scanne=
d
> +                to ensure the flow rule was created successfully.
>
>          Raises:
>              InteractiveCommandExecutionError: If flow rule is invalid.
>
>          Returns:
> -            Id of created flow rule.
> +            Id of created flow rule as an integer.
>          """
>          flow_output =3D self.send_command(f"flow create {port_id}
> {flow_rule}")
> +        if verify:
> +            if "created" not in flow_output:
> +                self._logger.debug(f"Failed to create flow
> rule:\n{flow_output}")
> +                raise InteractiveCommandExecutionError(
> +                    f"Failed to create flow rule:\n{flow_output}"
> +                )
>          match =3D re.search(r"#(\d+)", flow_output)
>          if match is not None:
>              match_str =3D match.group(1)
> @@ -1996,7 +2086,7 @@ def flow_delete(self, flow_id: int, port_id: int,
> verify: bool =3D True) -> None:
>          """Deletes the specified flow rule from the testpmd session.
>
>          Args:
> -            flow_id: ID of the flow to remove.
> +            flow_id: :class:`FlowRule` id used for deleting testpmd flow
> rule.
>              port_id: Integer representing the port to use.
>              verify: If :data:`True`, the output of the command is scanne=
d
>                  to ensure the flow rule was deleted successfully.
> --
> 2.43.0
>
>

--000000000000acaf9f063d3b76d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I think this patch looks good. Thanks Thomas and than=
ks Ivan for your insights.</div><div><br></div>Reviewed-by: Patrick Robb &l=
t;<a href=3D"mailto:probb@iol.unh.edu" target=3D"_blank">probb@iol.unh.edu<=
/a>&gt;</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Wed, Jul 30, 2025 at 8:59=E2=80=AFAM Thomas Wilks &lt;<a href=3D"=
mailto:thomas.wilks@arm.com" target=3D"_blank">thomas.wilks@arm.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Al=
ex Chapman &lt;<a href=3D"mailto:alex.chapman@arm.com" target=3D"_blank">al=
ex.chapman@arm.com</a>&gt;<br>
<br>
This patch adds the required functionality for the RSS key_update,<br>
RETA, and hash test suites. This includes:<br>
The setting of custom RETA values for routing packets to specific<br>
queues.<br>
The setting of the RSS mode on all ports, to specify how to hash<br>
the packets.<br>
The updating of the RSS hash key used during the hashing process.<br>
<br>
Alongside this, there is the addition of a __str__ method to the<br>
RSSOffloadTypesFlags class, so that when flag names are cast to<br>
a string they will use &#39;-&#39; as separators, instead of &#39;_&#39;.<b=
r>
This allows them to be directly used within testpmd RSS commands<br>
without any further changes.<br>
<br>
Signed-off-by: Alex Chapman &lt;<a href=3D"mailto:alex.chapman@arm.com" tar=
get=3D"_blank">alex.chapman@arm.com</a>&gt;<br>
Signed-off-by: Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@arm.com" tar=
get=3D"_blank">thomas.wilks@arm.com</a>&gt;<br>
<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
Reviewed-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=
=3D"_blank">probb@iol.unh.edu</a>&gt;<br>
Tested-by: Patrick Robb &lt;<a href=3D"mailto:probb@iol.unh.edu" target=3D"=
_blank">probb@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/framework/remote_session/testpmd_shell.py | 104 ++++++++++++++++-=
-<br>
=C2=A01 file changed, 97 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/=
remote_session/testpmd_shell.py<br>
index ad8cb273dc..473333f8fb 100644<br>
--- a/dts/framework/remote_session/testpmd_shell.py<br>
+++ b/dts/framework/remote_session/testpmd_shell.py<br>
@@ -343,6 +343,12 @@ def make_parser(cls) -&gt; ParserFn:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RSSOffloadTypesFlag.from_li=
st_string,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
<br>
+=C2=A0 =C2=A0 def __str__(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Replaces underscores with hy=
phens to produce valid testpmd value.&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if <a href=3D"http://self.name" rel=3D"norefer=
rer" target=3D"_blank">self.name</a> is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.name.replace(&quot;_&quot;, &quot;=
-&quot;)<br>
+<br>
<br>
=C2=A0class DeviceCapabilitiesFlag(Flag):<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Flag representing the device capabili=
ties.&quot;&quot;&quot;<br>
@@ -644,11 +650,13 @@ class TestPmdPort(TextParser):<br>
=C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0#: Maximum number of VFs<br>
=C2=A0 =C2=A0 =C2=A0max_vfs_num: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Maximum number of VFs: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
number of VFs: (\d+)&quot;),<br>
=C2=A0 =C2=A0 =C2=A0)<br>
=C2=A0 =C2=A0 =C2=A0#: Maximum number of VMDq pools<br>
=C2=A0 =C2=A0 =C2=A0max_vmdq_pools_num: int | None =3D field(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone, metadata=3DTextParser.find_int=
(r&quot;Maximum number of VMDq pools: (\d+)&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3DNone,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 metadata=3DTextParser.find_int(r&quot;Maximum =
number of VMDq pools: (\d+)&quot;),<br>
=C2=A0 =C2=A0 =C2=A0)<br>
<br>
=C2=A0 =C2=A0 =C2=A0#:<br>
@@ -1734,6 +1742,82 @@ def close_all_ports(self, verify: bool =3D True) -&g=
t; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not all(f&quot;Port {p_i=
d} is closed&quot; in port_close_output for p_id in range(num_ports)):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise Interac=
tiveCommandExecutionError(&quot;Ports were not closed successfully.&quot;)<=
br>
<br>
+=C2=A0 =C2=A0 def port_config_rss_reta(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, port_id: int, hash_index: int, queue_id:=
 int, verify: bool =3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Configure a port&#39;s RSS r=
edirection table.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port where the redi=
rection table will be configured.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hash_index: The index into the r=
edirection table associated with the destination queue.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_id: The destination queue =
of the packet.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, verifie=
s if a port&#39;s redirection table<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 was correctly conf=
igured.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Testpmd failed to =
config RSS reta.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out =3D self.send_command(f&quot;port config {=
port_id} rss reta ({hash_index},{queue_id})&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f&quot;The reta size of port =
{port_id} is&quot; not in out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to config RSS reta: \n{out}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(&quot;Testpmd failed to config RSS reta.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def port_config_all_rss_offload_type(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self, flag: RSSOffloadTypesFlag, verify: bool =
=3D True<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set the RSS mode on all port=
s.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag: The RSS iptype all ports w=
ill be configured to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, it veri=
fies if all ports RSS offload type<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 was correctly conf=
igured.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Testpmd failed to =
config the RSS mode on all ports.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out =3D self.send_command(f&quot;port config a=
ll rss {<a href=3D"http://flag.name" rel=3D"noreferrer" target=3D"_blank">f=
lag.name</a>}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;error&quot; in out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to config the RSS mode on all ports: \n{out}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to change RSS mode to {<a href=3D"http://flag.name" rel=
=3D"noreferrer" target=3D"_blank">flag.name</a>}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 def port_config_rss_hash_key(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: int,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 offload_type: RSSOffloadTypesFlag,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_str: str,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: bool =3D True,<br>
+=C2=A0 =C2=A0 ) -&gt; str:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Sets the RSS hash key for th=
e specified port.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_id: The port that will have=
 the hash key applied to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 offload_type: The offload type t=
he hash key will be applied to.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hex_str: The hash key to set.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, verify =
that RSS has the key.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If `verify` is :data:`True`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Testpmd failed to =
set the RSS hash key.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 output =3D self.send_command(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;port config {port_id} rss=
-hash-key {offload_type} {hex_str}&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 skip_first_line=3DTrue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if output.strip():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to set rss hash key: \n{output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Testpmd failed to set {hex_str} on {port_id} with a flag of {offload_typ=
e}.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return output<br>
+<br>
=C2=A0 =C2=A0 =C2=A0def show_port_info_all(self) -&gt; list[TestPmdPort]:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Returns the information=
 of all the ports.<br>
<br>
@@ -1952,22 +2036,28 @@ def csum_set_hw(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {port_id}:\n=
{csum_output}&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0)<br>
<br>
-=C2=A0 =C2=A0 def flow_create(self, flow_rule: FlowRule, port_id: int) -&g=
t; int:<br>
+=C2=A0 =C2=A0 def flow_create(self, flow_rule: FlowRule, port_id: int, ver=
ify: bool =3D True) -&gt; int:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Creates a flow rule in =
the testpmd session.<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 This command is implicitly verified as needed =
to return the created flow rule id.<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flow_rule: :class:`FlowRule=
` object used for creating testpmd flow rule.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port_id: Integer representi=
ng the port to use.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 verify: If :data:`True`, the out=
put of the command is scanned<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to ensure the flow=
 rule was created successfully.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Raises:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0InteractiveCommandExecution=
Error: If flow rule is invalid.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Returns:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Id of created flow rule.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Id of created flow rule as an in=
teger.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flow_output =3D self.send_command(f&quot;=
flow create {port_id} {flow_rule}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &quot;created&quot; not in fl=
ow_output:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._logger.debug=
(f&quot;Failed to create flow rule:\n{flow_output}&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&qu=
ot;Failed to create flow rule:\n{flow_output}&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0match =3D re.search(r&quot;#(\d+)&quot;, =
flow_output)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if match is not None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0match_str =3D match.group(1=
)<br>
@@ -1996,7 +2086,7 @@ def flow_delete(self, flow_id: int, port_id: int, ver=
ify: bool =3D True) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Deletes the specified f=
low rule from the testpmd session.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Args:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_id: ID of the flow to remov=
e.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_id: :class:`FlowRule` id us=
ed for deleting testpmd flow rule.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0port_id: Integer representi=
ng the port to use.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0verify: If :data:`True`, th=
e output of the command is scanned<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to ensure the=
 flow rule was deleted successfully.<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000acaf9f063d3b76d5--
